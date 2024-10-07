import pytest

from catalog_validation.utils import RE_VERSION_PATTERN


@pytest.mark.parametrize('version,result', [
    ('22.04-MASTER-12345678', '22.04'),
    ('24.10.1', '24.10.1'),
    ('23.12', '23.12'),
    ('22.02.0.1', '22.02.0.1'),
    ('22.02-ALPHA', '22.02'),
    ('24.04-MASTER', '24.04'),
    ('20.23-INTERNAL', '20.23'),
])
def test_version_regex_match(version, result):
    match = RE_VERSION_PATTERN.findall(version)
    assert len(match) == 1 and match[0] == result
