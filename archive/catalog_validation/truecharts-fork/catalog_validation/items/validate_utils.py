from catalog_validation.validation import validate_catalog_item, validate_catalog_item_version


def validate_item(path: str, schema: str, validate_versions: bool = True):
    validate_catalog_item(path, schema, validate_versions)


def validate_item_version(path: str, schema: str):
    validate_catalog_item_version(path, schema)
