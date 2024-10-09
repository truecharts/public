from catalog_validation.exceptions import ValidationErrors

from .schema_gen import get_schema


class Variable:
    def __init__(self, data):
        self.name = self.label = self.description = self.group = None
        self.schema = None
        self.update_from_data(data)

    def update_from_data(self, data):
        self.name = data.get('variable')
        self.label = data.get('label')
        self.description = data.get('description')
        self.schema = get_schema(data.get('schema'))

    def validate(self, schema):
        verrors = ValidationErrors()
        if not self.name:
            verrors.add(f'{schema}.variable', 'Variable value must be specified')

        if not self.schema:
            verrors.add(f'{schema}.schema', 'Schema must be specified for variable')
        else:
            try:
                self.schema.validate(f'{schema}.schema')
            except ValidationErrors as ve:
                verrors.extend(ve)

        verrors.check()

    def __str__(self):
        return self.name

    def __eq__(self, other):
        return (other if isinstance(other, str) else other.name) == self.name
