import os
import yaml

from catalog_validation.exceptions import ValidationErrors
from catalog_validation.validation import validate_catalog_item_version, validate_chart_version
from jsonschema import ValidationError as JsonValidationError

from .utils import (
    get_app_version, get_ci_development_directory, REQUIRED_METADATA_FILES, version_has_been_bumped,
    TO_KEEP_VERSIONS, REQUIRED_VERSIONS_SCHEMA, get_to_keep_versions, UPDATE_STRATEGY_FILE
)


def validate_dev_directory_structure(catalog_path: str, to_check_apps: dict) -> None:
    verrors = ValidationErrors()
    dev_directory = get_ci_development_directory(catalog_path)
    if not os.path.exists(dev_directory):
        return

    for train_name in filter(
        lambda name: name in to_check_apps and os.path.isdir(os.path.join(dev_directory, name)),
        os.listdir(dev_directory)
    ):
        validate_train(
            catalog_path, os.path.join(dev_directory, train_name), f'dev.{train_name}', to_check_apps[train_name]
        )
    verrors.check()


def validate_train(catalog_path: str, train_path: str, schema: str, to_check_apps: list) -> None:
    verrors = ValidationErrors()
    train_name = os.path.basename(train_path)
    for app_name in filter(
        lambda name: os.path.isdir(os.path.join(train_path, name)), os.listdir(train_path)
    ):
        if app_name not in to_check_apps:
            continue

        app_path = os.path.join(train_path, app_name)
        try:
            validate_app(app_path, f'{schema}.{app_name}')
        except ValidationErrors as ve:
            verrors.extend(ve)
        else:
            published_train_app_path = os.path.join(catalog_path, train_name, app_name)
            if not os.path.exists(published_train_app_path):
                # The application is new and we are good
                continue

            if not version_has_been_bumped(published_train_app_path, get_app_version(app_path)):
                verrors.add(
                    f'{schema}.{app_name}.version',
                    'Version must be bumped as app has been changed but version has not been updated'
                )

        verrors.check()


def validate_keep_versions(app_dir_path: str, schema: str, verrors: ValidationErrors) -> ValidationErrors:
    try:
        get_to_keep_versions(app_dir_path)
    except yaml.YAMLError:
        verrors.add(f'{schema}.{REQUIRED_VERSIONS_SCHEMA}', 'Invalid yaml format')
    except JsonValidationError:
        verrors.add(
            f'{schema}.{REQUIRED_VERSIONS_SCHEMA}',
            f'Invalid json schema {TO_KEEP_VERSIONS} must contain list of required versions'
        )


def validate_upgrate_strategy(app_path, schema, verrors):
    upgrade_strategy_path = os.path.join(app_path, UPDATE_STRATEGY_FILE)
    if os.path.exists(upgrade_strategy_path) and not os.access(upgrade_strategy_path, os.X_OK):
        verrors.add(schema, f'{upgrade_strategy_path!r} is not executable')


def validate_app(app_dir_path: str, schema: str) -> None:
    app_name = os.path.basename(app_dir_path)
    chart_version_path = os.path.join(app_dir_path, 'Chart.yaml')
    verrors = validate_chart_version(ValidationErrors(), chart_version_path, schema, app_name)
    validate_keep_versions(app_dir_path, app_name, verrors)
    verrors.check()

    validate_catalog_item_version(app_dir_path, schema, get_app_version(app_dir_path), app_name, True)

    required_files = set(REQUIRED_METADATA_FILES)
    available_files = set(
        f for f in filter(lambda f: os.path.isfile(os.path.join(app_dir_path, f)), os.listdir(app_dir_path))
    )
    if missing_files := required_files - available_files:
        verrors.add(
            f'{schema}.required_files',
            f'{", ".join(missing_files)!r} file(s) must be specified'
        )
    validate_upgrate_strategy(app_dir_path, f'{schema}.{UPDATE_STRATEGY_FILE}', verrors)
    verrors.check()
