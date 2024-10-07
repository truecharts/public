import os
import yaml

from catalog_validation.items.utils import DEVELOPMENT_DIR
from jsonschema import validate as json_schema_validate
from semantic_version import Version


DEV_DIRECTORY_RELATIVE_PATH: str = os.path.join('library', DEVELOPMENT_DIR)
TO_KEEP_VERSIONS = 'to_keep_versions.yaml'
OPTIONAL_METADATA_FILES = ['upgrade_info.json', 'upgrade_strategy', TO_KEEP_VERSIONS]
REQUIRED_METADATA_FILES = ['item.yaml']
UPDATE_STRATEGY_FILE = 'upgrade_strategy'


REQUIRED_VERSIONS_SCHEMA = {
    'type': 'array',
    'items': {
        'type': 'string',
        'pattern': '[0-9]+.[0-9]+.[0-9]+'
    }
}


def get_app_version(app_path: str) -> str:
    # This assumes that file exists and version is specified and is good
    with open(os.path.join(app_path, 'Chart.yaml'), 'r') as f:
        return yaml.safe_load(f.read())['version']


def get_ci_development_directory(catalog_path: str) -> str:
    return os.path.join(catalog_path, DEV_DIRECTORY_RELATIVE_PATH)


def get_to_keep_versions(app_dir_path: str) -> list:
    required_version_path = os.path.join(app_dir_path, TO_KEEP_VERSIONS)
    if not os.path.exists(required_version_path):
        return []

    with open(required_version_path, 'r') as f:
        data = yaml.safe_load(f.read())
        json_schema_validate(data, REQUIRED_VERSIONS_SCHEMA)
    return data


def version_has_been_bumped(app_path: str, new_version: str) -> bool:
    if not os.path.isdir(app_path):
        return True

    versions = [
        Version(version) for version in filter(lambda v: os.path.isdir(os.path.join(app_path, v)), os.listdir(app_path))
    ]
    versions.sort()
    return not versions or Version(new_version) > versions[-1]
