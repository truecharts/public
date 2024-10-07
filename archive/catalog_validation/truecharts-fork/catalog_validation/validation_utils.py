import os
import yaml

from semantic_version import Version
from typing import Optional

from .exceptions import ValidationErrors


def validate_chart_version(
    verrors: ValidationErrors, chart_version_path: str, schema: str, item_name: str, version_name: Optional[str] = None,
) -> ValidationErrors:
    if os.path.exists(chart_version_path):
        with open(chart_version_path, 'r') as f:
            try:
                chart_config = yaml.safe_load(f.read())
            except yaml.YAMLError:
                verrors.add(schema, 'Must be a valid yaml file')
            else:
                if not isinstance(chart_config, dict):
                    verrors.add(schema, 'Must be a dictionary')
                else:
                    if chart_config.get('name') != item_name:
                        verrors.add(f'{schema}.item_name', 'Item name not correctly set in "Chart.yaml".')

                    if not isinstance(chart_config.get('annotations', {}), dict):
                        verrors.add(f'{schema}.annotations', 'Annotations must be a dictionary')

                    if not isinstance(chart_config.get('sources', []), list):
                        verrors.add(f'{schema}.sources', 'Sources must be a list')
                    else:
                        for index, source in enumerate(chart_config.get('sources', [])):
                            if not isinstance(source, str):
                                verrors.add(f'{schema}.sources.{index}', 'Source must be a string')

                    if not isinstance(chart_config.get('maintainers', []), list):
                        verrors.add(f'{schema}.maintainers', 'Maintainers must be a list')
                    else:
                        for index, maintainer in enumerate(chart_config.get('maintainers', [])):
                            if not isinstance(maintainer, dict):
                                verrors.add(f'{schema}.maintainers.{index}', 'Maintainer must be a dictionary')
                            elif not all(k in maintainer and isinstance(maintainer[k], str) for k in ('name', 'email')):
                                verrors.add(
                                    f'{schema}.maintainers.{index}',
                                    'Maintainer must have name and email attributes defined and be strings.'
                                )

                    chart_version = chart_config.get('version')
                    if chart_version is None:
                        verrors.add(f'{schema}.version', 'Version must be configured in "Chart.yaml"')
                    else:
                        try:
                            Version(chart_version)
                        except ValueError:
                            verrors.add(f'{schema}.version', f'{chart_version!r} is not a valid version name')

                    if version_name is not None and chart_version != version_name:
                        verrors.add(
                            f'{schema}.version',
                            'Configured version in "Chart.yaml" does not match version directory name.'
                        )

    else:
        verrors.add(schema, 'Missing chart version file')

    return verrors
