import re


APP_MIGRATION_DIR = 'migrations'
APP_MIGRATION_SCHEMA = {
    'type': 'array',
    'items': {
        'type': 'object',
        'properties': {
            'app_name': {'type': 'string'},
            'action': {'type': 'string', 'enum': ['move']},
        },
        'required': [
            'app_name',
            'action'
        ],
        'allOf': [
            {
                'if': {
                    'properties': {
                        'action': {
                            'const': 'move',
                        },
                    },
                },
                'then': {
                    'properties': {
                        'old_train': {'type': 'string'},
                        'new_train': {'type': 'string'},
                    },
                    'required': [
                        'new_train',
                        'old_train',
                    ],
                },
            },
        ],
    },
}
MIGRATION_DIRS = ['.migrations', 'ix-migrations']
RE_MIGRATION_NAME_STR = r'^\d+\w+.json'
RE_MIGRATION_NAME = re.compile(RE_MIGRATION_NAME_STR)
