import concurrent.futures
import json
import jsonschema
import os
import yaml

from jsonschema import validate as json_schema_validate, ValidationError as JsonValidationError
from semantic_version import Version
from typing import Optional

from .exceptions import CatalogDoesNotExist, ValidationErrors
from .items.ix_values_utils import validate_ix_values_schema
from .items.questions_utils import (
    CUSTOM_PORTALS_KEY, CUSTOM_PORTALS_ENABLE_KEY, CUSTOM_PORTAL_GROUP_KEY,
)
from .items.utils import get_catalog_json_schema, RECOMMENDED_APPS_FILENAME, RECOMMENDED_APPS_SCHEMA, TRAIN_IGNORE_DIRS
from .schema.migration_schema import (
    APP_MIGRATION_SCHEMA, MIGRATION_DIRS, RE_MIGRATION_NAME, RE_MIGRATION_NAME_STR, APP_MIGRATION_DIR,
)
from .schema.variable import Variable
from .validation_utils import validate_chart_version
from .utils import (
    CACHED_CATALOG_FILE_NAME, CACHED_VERSION_FILE_NAME, METADATA_JSON_SCHEMA, validate_key_value_types,
    VALID_TRAIN_REGEX, VERSION_VALIDATION_SCHEMA, WANTED_FILES_IN_ITEM_VERSION
)


def validate_catalog(catalog_path, ignore_catalog_json=False):
    if not os.path.exists(catalog_path):
        raise CatalogDoesNotExist(catalog_path)

    verrors = ValidationErrors()
    items = []
    item_futures = []

    if not ignore_catalog_json:
        cached_catalog_file_path = os.path.join(catalog_path, CACHED_CATALOG_FILE_NAME)
        if not os.path.exists(cached_catalog_file_path):
            verrors.add(
                'cached_catalog_file',
                f'{CACHED_CATALOG_FILE_NAME!r} metadata file must be specified for a valid catalog'
            )
        else:
            try:
                with open(cached_catalog_file_path, 'r') as f:
                    json_schema_validate(json.loads(f.read()), get_catalog_json_schema())

            except (json.JSONDecodeError, JsonValidationError) as e:
                verrors.add(
                    'cached_catalog_file',
                    f'Failed to validate contents of {cached_catalog_file_path!r}: {e!r}'
                )

        verrors.check()

    validate_recommended_apps_file(catalog_path)

    for file_dir in os.listdir(catalog_path):
        complete_path = os.path.join(catalog_path, file_dir)
        if file_dir not in MIGRATION_DIRS and (
            file_dir.startswith('.') or not os.path.isdir(complete_path) or file_dir in TRAIN_IGNORE_DIRS
        ):
            continue
        if file_dir in MIGRATION_DIRS:
            if all(os.path.exists(migration_dir) for migration_dir in map(
                lambda d: os.path.join(catalog_path, d), MIGRATION_DIRS
            )):
                verrors.add(
                    'app_migrations', f'Both {", ".join(MIGRATION_DIRS)!r} cannot be used to specify app migrations'
                )
            else:
                for directory in MIGRATION_DIRS:
                    migration_dir = os.path.join(catalog_path, directory)
                    if not os.path.exists(migration_dir):
                        continue
                    if os.path.isdir(migration_dir):
                        try:
                            validate_migrations(migration_dir)
                        except ValidationErrors as e:
                            verrors.extend(e)
                    else:
                        verrors.add('app_migrations', f'{directory!r} is not a directory')
        else:
            try:
                validate_train_structure(complete_path)
            except ValidationErrors as e:
                verrors.extend(e)
            else:
                items.extend(get_train_items(complete_path))

    with concurrent.futures.ProcessPoolExecutor(max_workers=20 if len(items) > 10 else 5) as exc:
        for item in items:
            item_futures.append(exc.submit(validate_catalog_item, item[0], item[1]))

        for future in item_futures:
            try:
                future.result()
            except ValidationErrors as e:
                verrors.extend(e)

    verrors.check()


def validate_recommended_apps_file(catalog_location: str) -> None:
    verrors = ValidationErrors()
    try:
        with open(os.path.join(catalog_location, RECOMMENDED_APPS_FILENAME), 'r') as f:
            data = yaml.safe_load(f.read())
        json_schema_validate(data, RECOMMENDED_APPS_SCHEMA)
    except FileNotFoundError:
        return
    except yaml.YAMLError:
        verrors.add(RECOMMENDED_APPS_FILENAME, 'Must be a valid yaml file')
    except JsonValidationError as e:
        verrors.add(RECOMMENDED_APPS_FILENAME, f'Invalid format specified: {e}')

    verrors.check()


def validate_migrations(migration_dir):
    verrors = ValidationErrors()
    for migration_file in os.listdir(migration_dir):
        if not RE_MIGRATION_NAME.findall(migration_file):
            verrors.add(
                f'app_migrations.{migration_file}',
                'Invalid naming scheme used for migration file name. '
                f'It should be conforming to {RE_MIGRATION_NAME_STR!r} pattern.'
            )
        else:
            try:
                with open(os.path.join(migration_dir, migration_file), 'r') as f:
                    data = json.loads(f.read())
                jsonschema.validate(data, APP_MIGRATION_SCHEMA)
            except (json.JSONDecodeError, jsonschema.ValidationError) as e:
                verrors.add(
                    f'app_migrations.{migration_file}',
                    f'Failed to validate migration file structure: {e}'
                )
    verrors.check()


def validate_train_structure(train_path):
    train = os.path.basename(train_path)
    verrors = ValidationErrors()
    if not VALID_TRAIN_REGEX.match(train):
        verrors.add(train, 'Train name is invalid.')
    print(f' procssing train: {train} ')
    verrors.check()


def get_train_items(train_path):
    train = os.path.basename(train_path)
    items = []
    for catalog_item in os.listdir(train_path):
        item_path = os.path.join(train_path, catalog_item)
        if not os.path.isdir(item_path):
            continue
        items.append((item_path, f'{train}.{catalog_item}'))
    return items


def validate_catalog_item(catalog_item_path, schema, validate_versions=True):
    # We should ensure that each catalog item has at least 1 version available
    # Also that we have item.yaml present
    verrors = ValidationErrors()
    item_name = os.path.join(catalog_item_path)
    files = []
    versions = []
    print(f' procssing catalog item: {item_name} ')
    if not os.path.isdir(catalog_item_path):
        verrors.add(schema, 'Catalog item must be a directory')
    verrors.check()

    for file_dir in os.listdir(catalog_item_path):
        complete_path = os.path.join(catalog_item_path, file_dir)
        if os.path.isdir(complete_path):
            versions.append(complete_path)
        else:
            files.append(file_dir)

    if not versions:
        verrors.add(f'{schema}.versions', f'No versions found for {item_name} item.')

    if 'item.yaml' not in files:
        verrors.add(f'{schema}.item', 'Item configuration (item.yaml) not found')
    else:
        with open(os.path.join(catalog_item_path, 'item.yaml'), 'r') as f:
            item_config = yaml.safe_load(f.read())

        validate_key_value_types(
            item_config, (
                ('categories', list), ('tags', list, False), ('screenshots', list, False),
            ), verrors, f'{schema}.item_config'
        )

    cached_version_file_path = os.path.join(catalog_item_path, CACHED_VERSION_FILE_NAME)
    if os.path.exists(cached_version_file_path):
        try:
            with open(cached_version_file_path, 'r') as f:
                validate_catalog_item_version_data(
                    json.loads(f.read()), f'{schema}.{CACHED_VERSION_FILE_NAME}', verrors
                )
        except json.JSONDecodeError:
            verrors.add(
                f'{schema}.{CACHED_VERSION_FILE_NAME}', f'{CACHED_VERSION_FILE_NAME!r} is not a valid json file'
            )

    for version_path in (versions if validate_versions else []):
        try:
            validate_catalog_item_version(version_path, f'{schema}.versions.{os.path.basename(version_path)}')
        except ValidationErrors as e:
            verrors.extend(e)

    verrors.check()


def validate_app_migrations(version_path, schema):
    verrors = ValidationErrors()
    app_migration_path = os.path.join(version_path, APP_MIGRATION_DIR)

    if not os.path.exists(app_migration_path):
        return verrors

    for migration_file in os.listdir(app_migration_path):
        migration_file_path = os.path.join(app_migration_path, migration_file)
        if not os.access(migration_file_path, os.X_OK):
            verrors.add(schema, f'{migration_file!r} is not executable')
    return verrors


def validate_catalog_item_version_data(version_data: dict, schema: str, verrors: ValidationErrors) -> ValidationErrors:
    try:
        json_schema_validate(version_data, VERSION_VALIDATION_SCHEMA)
    except JsonValidationError as e:
        verrors.add(schema, f'Invalid format specified for application versions: {e}')
    return verrors


def validate_catalog_item_version(
    version_path: str, schema: str, version_name: Optional[str] = None, item_name: Optional[str] = None,
    validate_values: bool = False,
):
    verrors = ValidationErrors()
    version_name = version_name or os.path.basename(version_path)
    item_name = item_name or version_path.split('/')[-2]
    try:
        Version(version_name)
    except ValueError:
        verrors.add(f'{schema}.name', f'{version_name!r} is not a valid version name.')
    print(f' procssing catalog item version: {version_name} ')

    files_diff = WANTED_FILES_IN_ITEM_VERSION ^ set(
        f for f in os.listdir(version_path) if f in WANTED_FILES_IN_ITEM_VERSION
    )
    if files_diff:
        verrors.add(f'{schema}.required_files', f'Missing {", ".join(files_diff)} required configuration files.')

    chart_version_path = os.path.join(version_path, 'Chart.yaml')
    validate_chart_version(verrors, chart_version_path, schema, item_name, version_name)

    questions_path = os.path.join(version_path, 'questions.yaml')
    if os.path.exists(questions_path):
        try:
            validate_questions_yaml(questions_path, f'{schema}.questions_configuration')
        except ValidationErrors as v:
            verrors.extend(v)

    for values_file in ['ix_values.yaml'] + (['values.yaml'] if validate_values else []):
        values_path = os.path.join(version_path, values_file)
        if os.path.exists(values_path):
            try:
                validate_ix_values_yaml(values_path, f'{schema}.values_configuration')
            except ValidationErrors as v:
                verrors.extend(v)

    metadata_path = os.path.join(version_path, 'metadata.yaml')
    if os.path.exists(metadata_path):
        try:
            validate_metadata_yaml(metadata_path, f'{schema}.metadata_configuration')
        except ValidationErrors as v:
            verrors.extend(v)

    validate_app_migrations(version_path, f'{schema}.app_migrations')

    verrors.check()


def validate_ix_values_yaml(ix_values_yaml_path, schema):
    verrors = ValidationErrors()

    with open(ix_values_yaml_path, 'r') as f:
        try:
            ix_values = yaml.safe_load(f.read())
        except yaml.YAMLError:
            verrors.add(schema, 'Must be a valid yaml file')

        verrors.check()

    if isinstance(ix_values, dict):
        portals = ix_values.get(CUSTOM_PORTALS_KEY)
        if portals:
            try:
                validate_ix_values_schema(schema, portals)
            except ValidationErrors as ve:
                verrors.extend(ve)
    else:
        verrors.add(schema, 'Must be a dictionary')

    verrors.check()


def validate_metadata_yaml(metadata_yaml_path, schema):
    verrors = ValidationErrors()
    with open(metadata_yaml_path, 'r') as f:
        try:
            metadata = yaml.safe_load(f.read())
        except yaml.YAMLError:
            verrors.add(schema, 'Must be a valid yaml file')
        else:
            try:
                json_schema_validate(metadata, METADATA_JSON_SCHEMA)
            except JsonValidationError as e:
                verrors.add(schema, f'Invalid format specified for application metadata: {e}')

    verrors.check()


def validate_questions_yaml(questions_yaml_path, schema):
    verrors = ValidationErrors()

    with open(questions_yaml_path, 'r') as f:
        try:
            questions_config = yaml.safe_load(f.read())
        except yaml.YAMLError:
            verrors.add(schema, 'Must be a valid yaml file')
        else:
            if not isinstance(questions_config, dict):
                verrors.add(schema, 'Must be a dictionary')

    verrors.check()

    validate_key_value_types(
        questions_config, (
            ('groups', list), ('questions', list), ('portals', dict, False), (CUSTOM_PORTALS_ENABLE_KEY, bool, False),
            (CUSTOM_PORTAL_GROUP_KEY, str, False),
        ), verrors, schema
    )

    verrors.check()

    groups = []
    for index, group in enumerate(questions_config['groups']):
        if not isinstance(group, dict):
            verrors.add(f'{schema}.groups.{index}', 'Type of group should be a dictionary.')
            continue

        if group.get('name'):
            groups.append(group['name'])

        validate_key_value_types(group, (('name', str), ('description', str)), verrors, f'{schema}.group.{index}')

    for index, portal_details in enumerate((questions_config.get('portals') or {}).items()):
        portal_type, portal_schema = portal_details
        error_schema = f'{schema}.portals.{index}'
        if not isinstance(portal_type, str):
            verrors.add(error_schema, 'Portal type must be a string')
        if not isinstance(portal_schema, dict):
            verrors.add(error_schema, 'Portal schema must be a dictionary')
        else:
            validate_key_value_types(
                portal_schema, (('protocols', list), ('host', list), ('ports', list), ('path', str, False)),
                verrors, error_schema
            )

    validate_variable_uniqueness(questions_config['questions'], f'{schema}.questions', verrors)
    for index, question in enumerate(questions_config['questions']):
        validate_question(question, f'{schema}.questions.{index}', verrors, (('group', str),))
        if question.get('group') and question['group'] not in groups:
            verrors.add(f'{schema}.questions.{index}.group', f'Please specify a group declared in "{schema}.groups"')

    if questions_config.get(CUSTOM_PORTALS_ENABLE_KEY):
        if not questions_config.get(CUSTOM_PORTAL_GROUP_KEY):
            verrors.add(
                f'{schema}.{CUSTOM_PORTALS_ENABLE_KEY}',
                f'{CUSTOM_PORTAL_GROUP_KEY!r} must be specified when user specified portals are desired'
            )
        elif questions_config[CUSTOM_PORTAL_GROUP_KEY] not in groups:
            verrors.add(
                f'{schema}.{CUSTOM_PORTAL_GROUP_KEY}',
                'Specified group not declared under "groups"'
            )

    verrors.check()


def validate_variable_uniqueness(data, schema, verrors):
    variables = []
    for index, question in enumerate(data):
        if question['variable'] in variables:
            verrors.add(
                f'{schema}.{index}', f'Variable name {question["variable"]!r} has been used again which is not allowed'
            )
        else:
            variables.append(question['variable'])
            sub_questions = question.get('subquestions') or []
            for sub_index, sub_question in enumerate(sub_questions):
                if sub_question['variable'] in variables:
                    verrors.add(
                        f'{schema}.{index}.subquestions.{sub_index}',
                        f'Variable name {sub_question["variable"]!r} has been used again which is not allowed'
                    )
                else:
                    variables.append(sub_question['variable'])

    verrors.check()


def validate_question(question_data, schema, verrors, validate_top_level_attrs=None):
    if not isinstance(question_data, dict):
        verrors.add(schema, 'Question must be a valid dictionary.')
        return

    validate_top_level_attrs = validate_top_level_attrs or tuple()
    validate_key_value_types(
        question_data, (('variable', str), ('label', str), ('schema', dict)) + validate_top_level_attrs, verrors, schema
    )
    if type(question_data.get('schema')) != dict:
        return

    if question_data['variable'] == CUSTOM_PORTALS_KEY:
        verrors.add(
            f'{schema}.variable',
            f'{CUSTOM_PORTALS_KEY!r} is a reserved variable name and cannot be specified by app developer'
        )
        # No need to validate the question data etc here
        return

    try:
        Variable(question_data).validate(schema)
    except ValidationErrors as ve:
        verrors.extend(ve)
        return

    schema_data = question_data['schema']
    variable_type = schema_data['type']

    for condition, key, schema_str in (
        (variable_type != 'list', 'subquestions', f'{schema}.schema.subquestions'),
        (variable_type == 'list', 'items', f'{schema}.schema.items'),
        (variable_type == 'dict', 'attrs', f'{schema}.schema.attrs'),
    ):
        if not (condition and type(schema_data.get(key)) == list):
            continue

        if variable_type == 'dict':
            validate_variable_uniqueness(schema_data[key], f'{schema}.{schema_str}', verrors)

        for index, item in enumerate(schema_data[key]):
            validate_question(item, f'{schema_str}.{index}', verrors)
