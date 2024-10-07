import re


CACHED_CATALOG_FILE_NAME = 'catalog.json'
CACHED_VERSION_FILE_NAME = 'app_versions.json'
METADATA_JSON_SCHEMA = {
    'type': 'object',
    'properties': {
        'runAsContext': {
            'type': 'array',
            'items': {
                'type': 'object',
                'properties': {
                    'description': {'type': 'string'},
                    'gid': {'type': 'integer'},
                    'groupName': {'type': 'string'},
                    'userName': {'type': 'string'},
                    'uid': {'type': 'integer'},
                },
                'required': ['description'],
            },
        },
        'capabilities': {
            'type': 'array',
            'items': {
                'type': 'object',
                'properties': {
                    'description': {'type': 'string'},
                    'name': {'type': 'string'},
                },
                'required': ['description', 'name'],
            },
        },
        'hostMounts': {
            'type': 'array',
            'items': {
                'type': 'object',
                'properties': {
                    'description': {'type': 'string'},
                    'hostPath': {'type': 'string'},
                },
                'required': ['description', 'hostPath'],
            },
        },
    },
}
VALID_TRAIN_REGEX = re.compile(r'^\w+[\w.-]*$')
VERSION_VALIDATION_SCHEMA = {
    'type': 'object',
    'title': 'Versions',
    'patternProperties': {
        '[0-9]+.[0-9]+.[0-9]+': {
            'type': 'object',
            'properties': {
                'healthy': {
                    'type': 'boolean',
                },
                'supported': {
                    'type': 'boolean',
                },
                'healthy_error': {
                    'type': ['string', 'null']
                },
                'location': {
                    'type': 'string',
                    'pattern': r'^(\/[a-zA-Z0-9_.-]+)+$'
                },
                'last_update': {
                    'type': 'string',
                    'pattern': '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'
                },
                'required_features': {
                    'type': 'array',
                    'items': {
                        'type': 'string'
                    }
                },
                'human_version': {
                    'type': 'string'
                },
                'version': {
                    'type': 'string',
                    'pattern': '[0-9]+.[0-9]+.[0-9]+'
                },
                'chart_metadata': {
                    'type': 'object',
                    'properties': {
                        'name': {
                            'type': 'string'
                        },
                        'description': {
                            'type': 'string'
                        },
                        'annotations': {
                            'type': 'object'
                        },
                        'type': {
                            'type': 'string'
                        },
                        'version': {
                            'type': 'string',
                            'pattern': '[0-9]+.[0-9]+.[0-9]+'
                        },
                        'apiVersion': {
                            'type': 'string',
                        },
                        'appVersion': {
                            'type': 'string'
                        },
                        'kubeVersion': {
                            'type': 'string'
                        },
                        'app_readme': {'type': 'string'},
                        'detailed_readme': {'type': 'string'},
                        'changelog': {'type': ['string', 'null']},
                        'maintainers': {
                            'type': 'array',
                            'items': {
                                'type': 'object',
                                'properties': {
                                    'name': {'type': 'string'},
                                    'url': {'type': ['string', 'null']},
                                    'email': {'type': 'string'},
                                },
                                'required': ['name', 'email'],
                            }
                        },
                        'dependencies': {
                            'type': 'array',
                            'items': {
                                'type': 'object',
                                'properties': {
                                    'name': {'type': 'string'},
                                    'repository': {'type': 'string'},
                                    'version': {'type': 'string'}
                                }
                            }
                        },
                        'home': {'type': 'string'},
                        'icon': {'type': 'string'},
                        'sources': {
                            'type': 'array',
                            'items': {
                                'type': 'string'
                            }
                        },
                        'keywords': {
                            'type': 'array',
                            'items': {
                                'type': 'string'
                            }
                        },
                    }
                },
                'app_metadata': {
                    **METADATA_JSON_SCHEMA,
                    'type': ['object', 'null'],
                },
                'schema': {
                    'type': 'object',
                    'properties': {
                        'groups': {
                            'type': 'array',
                            'items': {
                                'type': 'object',
                                'properties': {
                                    'name': {
                                        'type': 'string'
                                    },
                                    'description': {
                                        'type': 'string'
                                    },
                                },
                                'required': ['description', 'name'],
                            }
                        },
                        'portals': {
                            'type': 'object'
                        },
                        'questions': {
                            'type': 'array',
                            'items': {
                                'type': 'object',
                                'properties': {
                                    'variable': {'type': 'string'},
                                    'label': {'type': 'string'},
                                    'group': {'type': 'string'},
                                    'schema': {
                                        'type': 'object',
                                        'properties': {
                                            'type': {'type': 'string'}
                                        },
                                        'required': ['type']
                                    }
                                }
                            }
                        }
                    },
                    'required': ['groups', 'questions']
                },
            },
            'required': [
                'healthy', 'supported', 'healthy_error', 'location', 'last_update', 'required_features',
                'human_version', 'version', 'chart_metadata', 'app_metadata', 'schema',
            ],
        },
    },
    'additionalProperties': False
}
WANTED_FILES_IN_ITEM_VERSION = {'questions.yaml', 'app-readme.md', 'Chart.yaml', 'README.md'}


def validate_key_value_types(data_to_check, mapping, verrors, schema):
    for key_mapping in mapping:
        if len(key_mapping) == 2:
            key, value_type, required = *key_mapping, True
        else:
            key, value_type, required = key_mapping

        if required and key not in data_to_check:
            verrors.add(f'{schema}.{key}', f'Missing required {key!r} key.')
        elif key in data_to_check and not isinstance(data_to_check[key], value_type):
            verrors.add(f'{schema}.{key}', f'{key!r} value should be a {value_type.__name__!r}')
