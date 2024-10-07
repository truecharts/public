import itertools

from .utils import ACL_QUESTION, IX_VOLUMES_ACL_QUESTION


CUSTOM_PORTALS_KEY = 'iXPortals'
CUSTOM_PORTALS_ENABLE_KEY = 'enableIXPortals'
CUSTOM_PORTAL_GROUP_KEY = 'iXPortalsGroupName'


def get_custom_portal_question(group_name: str) -> dict:
    return {
        'variable': CUSTOM_PORTALS_KEY,
        'label': 'User Specified Web Portals',
        'description': 'User(s) can specify custom webUI portals',
        'group': group_name,
        'schema': {
            'type': 'list',
            'items': [{
                'variable': 'portalConfiguration',
                'label': 'Portal Configuration',
                'description': 'Configure WebUI Portal',
                'schema': {
                    'type': 'dict',
                    'attrs': [
                        {
                            'variable': 'portalName',
                            'label': 'Portal Name',
                            'description': 'Specify a UI Portal name to use which would be displayed in the UI',
                            'schema': {
                                'type': 'string',
                                'default': 'Web Portal',
                                'empty': False,
                            },
                        },
                        {
                            'variable': 'protocol',
                            'label': 'Protocol for Portal',
                            'description': 'Specify protocol for Portal',
                            'schema': {
                                'type': 'string',
                                'default': 'http',
                                'enum': [
                                    {'value': 'http', 'description': 'HTTP Protocol'},
                                    {'value': 'https', 'description': 'HTTPS Protocol'},
                                ],
                            },
                        },
                        {
                            'variable': 'useNodeIP',
                            'label': 'Use Node IP for Portal IP/Domain',
                            'schema': {
                                'type': 'boolean',
                                'default': True,
                            },
                        },
                        {
                            'variable': 'host',
                            'label': 'Portal IP/Domain',
                            'schema': {
                                'type': 'string',
                                'show_if': [['useNodeIP', '=', False]],
                                '$ref': ['definitions/nodeIP'],
                            },
                        },
                        {
                            'variable': 'port',
                            'label': 'Port',
                            'description': 'Specify port to be used for Portal access',
                            'schema': {
                                'type': 'int',
                                'max': 65535,
                                'default': 15000,
                            },
                        },
                        {
                            'variable': 'path',
                            'label': 'Path (optional - leave empty if not required)',
                            'description': 'Some app(s) might have a sub path i.e http://192.168.0.10:9000/api/',
                            'schema': {
                                'type': 'string',
                            },
                        },
                    ],
                },
            }],
        },
    }


def normalise_questions(version_data: dict, context: dict) -> None:
    version_data['required_features'] = set()
    version_data['schema']['questions'].extend(
        [
            get_custom_portal_question(version_data['schema'][CUSTOM_PORTAL_GROUP_KEY])
        ] if version_data['schema'].get(CUSTOM_PORTALS_ENABLE_KEY) else []
    )
    for question in version_data['schema']['questions']:
        normalise_question(question, version_data, context)
    version_data['required_features'] = list(version_data['required_features'])


def normalise_question(question: dict, version_data: dict, context: dict) -> None:
    schema = question['schema']
    for attr in itertools.chain(*[schema.get(k, []) for k in ('attrs', 'items', 'subquestions')]):
        normalise_question(attr, version_data, context)

    if '$ref' not in schema:
        return

    data = {}
    for ref in schema['$ref']:
        version_data['required_features'].add(ref)
        if ref == 'definitions/interface':
            data['enum'] = [
                {'value': i, 'description': f'{i!r} Interface'} for i in context['nic_choices']
            ]
        elif ref == 'definitions/gpuConfiguration':
            data['attrs'] = [
                {
                    'variable': gpu,
                    'label': f'GPU Resource ({gpu})',
                    'description': 'Please enter the number of GPUs to allocate',
                    'schema': {
                        'type': 'int',
                        'max': int(quantity),
                        'enum': [
                            {'value': i, 'description': f'Allocate {i!r} {gpu} GPU'}
                            for i in range(int(quantity) + 1)
                        ],
                        'default': 0,
                    }
                } for gpu, quantity in context['gpus'].items()
            ]
        elif ref == 'definitions/timezone':
            data.update({
                'enum': [{'value': t, 'description': f'{t!r} timezone'} for t in sorted(context['timezones'])],
                'default': context['system.general.config']['timezone']
            })
        elif ref == 'definitions/nodeIP':
            data['default'] = context['node_ip']
        elif ref == 'definitions/certificate':
            get_cert_ca_options(schema, data, {'value': None, 'description': 'No Certificate'})
            data['enum'] += [
                {'value': i['id'], 'description': f'{i["name"]!r} Certificate'}
                for i in context['certificates']
            ]
        elif ref == 'definitions/certificateAuthority':
            get_cert_ca_options(schema, data, {'value': None, 'description': 'No Certificate Authority'})
            data['enum'] += [{'value': None, 'description': 'No Certificate Authority'}] + [
                {'value': i['id'], 'description': f'{i["name"]!r} Certificate Authority'}
                for i in context['certificate_authorities']
            ]
        elif ref == 'definitions/port':
            data['enum'] = [{'value': None, 'description': 'No Port Selected'}] if schema.get('null') else []
            data['enum'] += [
                {'value': i, 'description': f'{i!r} Port'}
                for i in filter(
                    lambda p: schema.get('min', 9000) <= p <= schema.get('max', 65534),
                    context['unused_ports']
                )
            ]
        elif ref == 'normalize/acl':
            data['attrs'] = ACL_QUESTION
        elif ref == 'normalize/ixVolume':
            if schema['type'] == 'dict' and any(i['variable'] == 'aclEntries' for i in schema['attrs']):
                # get index of aclEntries from attrs
                acl_index = next(i for i, v in enumerate(schema['attrs']) if v['variable'] == 'aclEntries')
                # insert acl question before aclEntries
                schema['attrs'][acl_index]['schema']['attrs'] = IX_VOLUMES_ACL_QUESTION

    schema.update(data)


def get_cert_ca_options(schema: dict, data: dict, default_entry: dict):
    if schema.get('null', True):
        data.update({
            'enum': [default_entry],
            'default': None,
            'null': True,
        })
    else:
        data.update({
            'enum': [],
            'required': True,
        })
