from jsonschema import validate as json_schema_validate, ValidationError as JsonValidationError

from catalog_validation.exceptions import ValidationErrors


CUSTOM_PORTALS_JSON_SCHEMA = {
    'type': 'array',
    'items': {
        'type': 'object',
        'properties': {
            'portalName': {
                'type': 'string',
            },
            'protocol': {
                'type': 'string', 'enum': ['http', 'https'],
            },
            'useNodeIP': {
                'type': 'boolean',
            },
            'port': {
                'type': 'integer',
            },
            'path': {
                'type': 'string',
            },
        },
        'allOf': [
            {
                'if': {
                    'properties': {
                        'useNodeIP': {
                            'const': False,
                        },
                    },
                },
                'then': {
                    'required': ['host'],
                    'properties': {
                        'host': {
                            'type': 'string',
                        },
                    },
                },
            }],
        'required': ['portalName', 'protocol', 'useNodeIP', 'port'],
    },
}


def validate_ix_values_schema(schema, data):
    verrors = ValidationErrors()

    try:
        json_schema_validate(data, CUSTOM_PORTALS_JSON_SCHEMA)
    except JsonValidationError as e:
        verrors.add(schema, f'Failed to validate schema: {e}')

    verrors.check()
