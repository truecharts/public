import pytest
from catalog_validation.validation import validate_ix_values_yaml
from catalog_validation.exceptions import ValidationErrors


@pytest.mark.parametrize('schema, ix_values_yaml_path, test_yaml, should_work', [

    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '''
        image:
          pullPolicy: IfNotPresent
          repository: ixsystems/chia-docker
          tag: v1.6.2
        updateStrategy: Recreate
        iXPortals: [{portalName: 'web portal', protocol: 'http', useNodeIP: false, host: '192.168.0.18', port: 9898}]
        ''',
        True
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '''
        image:
          pullPolicy: IfNotPresent
          repository: ixsystems/chia-docker
          tag: v1.6.2
        updateStrategy: Recreate
        iXPortals: [{portalName: 'web portal', protocol: 'http', useNodeIP: true, port: 9898}]
        ''',
        True
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '''
        image:
          pullPolicy: IfNotPresent
          repository: ixsystems/chia-docker
          tag: v1.6.2
        updateStrategy: Recreate
        iXPortals: [{portalName: 'web portal', protocol: 'htts', useNodeIP: true, port: 9898}]
        ''',
        False
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '''
        image:
          pullPolicy: IfNotPresent
          repository: ixsystems/chia-docker
          tag: v1.6.2
        updateStrategy: Recreate
        iXPortals: [{portalName: 'web portal', protocol: 09088, useNodeIP: true, port: '9898'}]
        ''',
        False
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '''
        image:
          pullPolicy: IfNotPresent
          repository: ixsystems/chia-docker
          tag: v1.6.2
        updateStrategy: Recreate
        iXPortals: [{portalName: 'web portal', useNodeIP: true, port: '9898'}]
        ''',
        False
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        '',
        False,
    ),
    (
        'charts.chia.versions.1.3.38.ix_values',
        '/mnt/crave/ix-applications/catalogs/github_com_truenas_charts_git_master/test/chia/1.3.38/ix_values.yaml',
        'image pullPolicy ifNotPresent',
        False,
    )
])
def test_validate_ix_values(mocker, schema, ix_values_yaml_path, test_yaml, should_work):
    open_file = mocker.mock_open(read_data=test_yaml)
    mocker.patch('builtins.open', open_file)

    if should_work:
        assert validate_ix_values_yaml(ix_values_yaml_path, schema) is None
    else:
        with pytest.raises(ValidationErrors):
            validate_ix_values_yaml(ix_values_yaml_path, schema)
