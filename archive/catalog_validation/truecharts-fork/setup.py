from distutils.core import setup
from setuptools import find_packages

VERSION = '0.1'

setup(
    name='catalog_validation',
    description='Validate TrueNAS Catalog(s)',
    version=VERSION,
    include_package_data=True,
    packages=find_packages(),
    license='GNU3',
    platforms='any',
    entry_points={
        'console_scripts': [
            'catalog_validate = catalog_validation.scripts.catalog_validate:main',
            'catalog_update = catalog_validation.scripts.catalog_update:main',
            'dev_charts_validate = catalog_validation.scripts.dev_apps_validate:main',
        ],
    },
)
