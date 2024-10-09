from catalog_validation.items.questions_utils import normalise_question
import pytest


VERSION_DATA = {
    'location': '/mnt/mypool/ix-applications/catalogs/github_com_truenas_charts_git_master/charts/syncthing/1.0.14',
    'required_features': {
        'normalize/ixVolume',
        'validations/lockedHostPath',
    },
    'chart_metadata': {},
    'schema': {
        'variable': 'hostNetwork',
        'label': 'Host Network',
        'group': 'Networking',
    },
    'app_readme': 'there is not any',
    'detailed_readme': 'there is not any',
    'changelog': None,
}


@pytest.mark.parametrize('question,normalise_data,context', [
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/interface'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/interface'],
                'enum': [],
            }
        }, {
            'nic_choices': [],
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/interface'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/interface'],
                'enum': [{
                    'value': 'ens0',
                    'description': "'ens0' Interface"
                }],
            }
        }, {
            'nic_choices': ['ens0']
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/gpuConfiguration'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/gpuConfiguration'],
                'attrs': [{
                    'variable': 'test@gpu',
                    'label': 'GPU Resource (test@gpu)',
                    'description': 'Please enter the number of GPUs to allocate',
                    'schema': {
                        'type': 'int',
                        'max': 3,
                        'enum': [
                            {'value': i, 'description': f'Allocate {i!r} test@gpu GPU'}
                            for i in range(4)
                        ],
                        'default': 0,
                    }
                }],
            }
        }, {
            'gpus': {
                'test@gpu': 3
            }
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/gpuConfiguration'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/gpuConfiguration'],
                'attrs': [],
            }
        }, {
            'gpus': {}
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/timezone'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/timezone'],
                'enum': [{
                    'value': 'Asia/Damascus',
                    'description': "'Asia/Damascus' timezone",
                }, {
                    'value': 'Asia/Saigon',
                    'description': "'Asia/Saigon' timezone",
                }],
                'default': 'America/Los_Angeles',
            }
        },
        {
            'timezones': {
                'Asia/Saigon': 'Asia/Saigon',
                'Asia/Damascus': 'Asia/Damascus',
            },
            'system.general.config': {
                'timezone': 'America/Los_Angeles',
            }
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/nodeIP'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/nodeIP'],
                'default': '192.168.0.10',
            }
        },
        {
            'node_ip': '192.168.0.10'
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificate'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificate'],
                'enum': [{
                    'value': None,
                    'description': 'No Certificate'
                },
                    {
                        'value': '1',
                        'description': "'testcert' Certificate"
                    }
                ],
                'default': None,
                'null': True
            }
        }, {'certificates': [{
            'id': '1',
            'name': 'testcert'
        }],
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificate'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificate'],
                'enum': [{
                    'value': None,
                    'description': 'No Certificate'
                }],
                'default': None,
                'null': True
            }
        }, {
            'certificates': []
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificateAuthority'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificateAuthority'],
                'enum': [{
                    'value': None,
                    'description': 'No Certificate Authority'
                }, {
                    'value': None,
                    'description': 'No Certificate Authority'
                }],
                'default': None,
                'null': True
            }
        }, {
            'certificate_authorities': []
        }
    ),
    (
        {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificateAuthority'],
            }
        }, {
            'variable': 'datasetName',
            'label': 'Plots Volume Name',
            'schema': {
                'type': 'string',
                'hidden': True,
                '$ref': ['definitions/certificateAuthority'],
                'enum': [{
                    'value': None,
                    'description': 'No Certificate Authority'
                }, {
                    'value': None,
                    'description': 'No Certificate Authority'
                },
                    {
                        'value': '1',
                        'description': "'testca' Certificate Authority"
                    }
                ],
                'default': None,
                'null': True
            }
        }, {
            'certificate_authorities': [{
                'id': '1',
                'name': 'testca'
            }],
        }
    )
])
def test_normalise_question(question, normalise_data, context):
    normalise_question(question, VERSION_DATA, context)
    assert question == normalise_data
