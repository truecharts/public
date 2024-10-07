import pytest

from catalog_validation.exceptions import ValidationErrors
from catalog_validation.validation_utils import validate_min_max_version_values


@pytest.mark.parametrize(
    'annotations_dict,schema,expected_error',
    [
        (
            {
                'min_scale_version': '23.04',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            None
        ),
        (
            {
                'min_scale_version': '22.02-RC.2',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            None
        ),
        (
            {
                'min_scale_version': '24.04',
                'max_scale_version': '23.04'
            },
            'charts.plex.versions.1.7.56',
            'Provided min_scale_version is greater than provided max_scale_version'
        ),
        (
            {
                'min_scale_version': '12',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            'Format of provided min_scale_version value is not correct'
        ),
        (
            {
                'min_scale_version': '24.04-MASTER-20230928-144829',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            'Format of provided min_scale_version value is not correct'
        ),
        (
            {
                'min_scale_version': '22.12.2-INTERNAL.9',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            'Format of provided min_scale_version value is not correct'
        ),
        (
            {
                'min_scale_version': '23.04',
            },
            'charts.plex.versions.1.7.56',
            None
        ),
        (
            {
                'min_scale_version': 24.04,
            },
            'charts.plex.versions.1.7.56',
            '\'min_scale_version\' value should be a \'str\''
        ),
        (
            {
                'min_scale_version': None
            },
            'charts.plex.versions.1.7.56',
            '\'min_scale_version\' value should be a \'str\''
        ),
        (
            {
                'min_scale_version': '22.02.CUSTOM',
            },
            'charts.plex.versions.1.7.56',
            'Format of provided min_scale_version value is not correct'
        ),
        (
            {
                'min_scale_version': 'TrueNAS-SCALE-22.02-RC.1',
                'max_scale_version': '24.04'
            },
            'charts.plex.versions.1.7.56',
            'Format of provided min_scale_version value is not correct'
        ),
    ]
)
def test_validate_min_max_version_values(annotations_dict, schema, expected_error):
    verrors = ValidationErrors()
    if expected_error:
        with pytest.raises(ValidationErrors) as ve:
            validate_min_max_version_values(annotations_dict, verrors, schema)
            verrors.check()
        assert ve.value.errors[0].errmsg == expected_error
    else:
        assert validate_min_max_version_values(annotations_dict, verrors, schema) is None
