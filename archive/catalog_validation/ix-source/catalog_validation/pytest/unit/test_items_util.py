import pytest

from catalog_validation.items.items_util import get_item_details, get_item_details_impl


QUESTION_CONTEXT = {
    'nic_choices': [],
    'gpus': {},
    'timezones': {'Asia/Saigon': 'Asia/Saigon', 'Asia/Damascus': 'Asia/Damascus'},
    'node_ip': '192.168.0.10',
    'certificates': [],
    'certificate_authorities': [],
    'system.general.config': {'timezone': 'America/Los_Angeles'},
}


@pytest.mark.parametrize('item_location,options,items_data', [
    ('/mnt/mypool/ix-applications/catalogs/github_com_truenas_charts_git_master/charts/chia',
     {'retrieve_versions': True},
     {
         'name': 'chia',
         'categories': [],
         'app_readme': None,
         'location': '/mnt/mypool/ix-applications/catalogs/github_com_truenas_charts_git_master/charts/chia',
         'healthy': True,
         'healthy_error': None,
         'home': None,
         'last_update': None,
         'versions': {},
         'maintainers': [],
         'latest_version': None,
         'latest_app_version': None,
         'latest_human_version': None,
         'recommended': False,
         'title': 'Chia',
         'description': None,
         'tags': [],
         'screenshots': [],
         'sources': [],
     }
     ),
])
def test_get_item_details(mocker, item_location, options, items_data):
    mocker.patch('catalog_validation.items.items_util.validate_item', return_value=None)
    mocker.patch('catalog_validation.items.items_util.get_item_details_impl', return_value={})
    assert get_item_details(item_location, QUESTION_CONTEXT, options) == items_data


@pytest.mark.parametrize('item_path,schema,options,yaml_data,item_data_impl,open_yaml', [
    (
        '/mnt/mypool/ix-applications/catalogs/github_com_truenas_charts_git_master/charts/chia',
        'charts.chia',
        {'retrieve_latest_version': True}, {
            'variable': 'web_port',
            'label': 'Web Port for Diskover',
            'group': 'Networking',
            'schema': {
                'type': 'int',
                'min': 8000,
                'max': 65535,
                'default': 22510,
                'required': True
            }
        }, {
            'versions': {
                '1.3.37': {
                    'healthy': True,
                    'supported': False,
                    'healthy_error': None,
                    'last_update': None,
                    'location': '/mnt/mypool/ix-applications/catalogs/github_com_truenas_'
                                'charts_git_master/charts/chia/1.3.37',
                    'required_features': [],
                    'human_version': '1.3.37',
                    'version': '1.3.37'
                }
            },
            'categories': ['storage', 'crypto'],
            'icon_url': 'https://www.chia.net/wp-content/uploads/2022/09/chia-logo.svg',
            'tags': ['finance'],
            'screenshots': ['https://www.chia.net/wp-content/uploads/2022/09/chia-logo.svg'],
            'sources': ['https://hub.docker.com/r/emby/embyserver'],
        },
        '''
        screenshots:
          - 'https://www.chia.net/wp-content/uploads/2022/09/chia-logo.svg'
        tags:
          - finance
        categories:
          - storage
          - crypto
        icon_url: https://www.chia.net/wp-content/uploads/2022/09/chia-logo.svg
        sources:
          - https://hub.docker.com/r/emby/embyserver
        '''
    ),
])
def test_get_item_details_impl(
    mocker, item_path, schema, options, yaml_data, item_data_impl, open_yaml,
):
    open_file_data = mocker.mock_open(read_data=open_yaml)
    mocker.patch('builtins.open', open_file_data)
    mocker.patch('os.path.isdir', return_value=True)
    mocker.patch('os.listdir', return_value=['1.3.37'])
    mocker.patch('catalog_validation.items.items_util.validate_item_version', return_value=None)
    mocker.patch('catalog_validation.items.items_util.get_item_version_details', return_value={})
    assert get_item_details_impl(item_path, schema, QUESTION_CONTEXT, options) == item_data_impl
