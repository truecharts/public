from jsonschema import validate as json_schema_validate, ValidationError as JsonValidationError

from catalog_validation.exceptions import ValidationErrors

from .feature_gen import get_feature
from .variable_gen import generate_variable


class Schema:

    DEFAULT_TYPE = NotImplementedError

    def __init__(self, include_subquestions_attrs=True, data=None):
        self.required = self.null = self.show_if = self.ref = self.ui_ref = self.type =\
            self.editable = self.hidden = self.default = self._schema_data = None
        self._skip_data_values = []
        if include_subquestions_attrs:
            self.subquestions = self.show_subquestions_if = None
        if data:
            self.initialize_values(data)

    def initialize_values(self, data):
        self._schema_data = data
        for key, value in filter(
            lambda k: hasattr(self, k[0]) and k[0] not in self._skip_data_values, data.items()
        ):
            setattr(self, key, value)

    def get_schema_str(self, schema):
        if schema:
            return f'{schema}.'
        return ''

    def validate(self, schema, data=None):
        if data:
            self.initialize_values(data)

        if not self._schema_data:
            raise Exception('Schema data must be initialized before validating schema')

        verrors = ValidationErrors()
        try:
            json_schema_validate(self._schema_data, self.json_schema())
        except JsonValidationError as e:
            verrors.add(schema, f'Failed to validate schema: {e}')

        verrors.check()

        if '$ref' in self._schema_data:
            for index, ref in enumerate(self._schema_data['$ref']):
                if not isinstance(ref, str):
                    verrors.add(f'{schema}.$ref.{index}', 'Must be a string')
                    continue

                feature_obj = get_feature(ref)
                if not feature_obj:
                    continue
                try:
                    feature_obj.validate(self, f'{schema}.$ref.{index}')
                except ValidationErrors as e:
                    verrors.extend(e)

        verrors.check()

    def json_schema(self):
        schema = {
            'type': 'object',
            'properties': {
                'required': {
                    'type': 'boolean',
                },
                'null': {
                    'type': 'boolean',
                },
                'show_if': {
                    'type': 'array',
                },
                '$ref': {
                    'type': 'array',
                },
                '$ui-ref': {
                    'type': 'array',
                },
                'subquestions': {
                    'type': 'array',
                },
                'show_subquestions_if': {
                    'type': ['string', 'integer', 'boolean', 'object', 'array', 'null'],
                },
                'type': {
                    'type': 'string',
                },
                'editable': {
                    'type': 'boolean',
                },
                'immutable': {
                    'type': 'boolean',
                },
                'hidden': {
                    'type': 'boolean',
                },
            },
            'required': ['type'],
            'dependentRequired': {
                'show_subquestions_if': ['subquestions']
            }
        }
        if self.DEFAULT_TYPE:
            schema['properties']['default'] = {
                'type': [self.DEFAULT_TYPE] + (['null'] if self.null else [])
            }
        if hasattr(self, 'enum'):
            schema['properties']['enum'] = {
                'type': 'array',
                'items': {
                    'type': 'object',
                    'properties': {
                        'value': {'type': [self.DEFAULT_TYPE] + (['null'] if self.null else [])},
                        'description': {'type': ['string', 'null']},
                    },
                    'additionalProperties': False,
                    'required': ['value', 'description']
                },
            }
        return schema


class BooleanSchema(Schema):
    DEFAULT_TYPE = 'boolean'


class StringSchema(Schema):
    DEFAULT_TYPE = 'string'

    def __init__(self, data):
        self.min_length = self.max_length = self.enum = self.private = self.valid_chars = self.valid_chars_error = None
        super().__init__(data=data)

    def json_schema(self):
        schema = super().json_schema()
        schema['properties'].update({
            'min_length': {
                'type': 'integer',
            },
            'max_length': {
                'type': 'integer',
            },
            'private': {
                'type': 'boolean',
            },
            'valid_chars': {
                'type': 'string',
            },
            'valid_chars_error': {
                'type': 'string'
            },
        })
        return schema


class IntegerSchema(Schema):
    DEFAULT_TYPE = 'integer'

    def __init__(self, data):
        self.min = self.max = self.enum = None
        super().__init__(data=data)

    def json_schema(self):
        schema = super().json_schema()
        schema['properties'].update({
            'min': {
                'type': 'integer',
            },
            'max': {
                'type': 'integer',
            },
        })
        return schema


class PathSchema(Schema):
    DEFAULT_TYPE = 'string'


class HostPathSchema(Schema):
    DEFAULT_TYPE = 'string'


class HostPathDirSchema(Schema):
    DEFAULT_TYPE = 'string'


class HostPathFileSchema(Schema):
    DEFAULT_TYPE = 'string'


class URISchema(Schema):
    DEFAULT_TYPE = 'string'


class IPAddrSchema(Schema):
    DEFAULT_TYPE = 'string'

    def __init__(self, data):
        self.ipv4 = self.ipv6 = self.cidr = None
        super().__init__(data=data)

    def json_schema(self):
        schema = super().json_schema()
        schema['properties'].update({
            'ipv4': {'type': 'boolean'},
            'ipv6': {'type': 'boolean'},
            'cidr': {'type': 'boolean'},
        })
        return schema


class CronSchema(Schema):
    DEFAULT_TYPE = 'object'


class DictSchema(Schema):
    DEFAULT_TYPE = 'object'

    def __init__(self, data):
        self.attrs = []
        self.additional_attrs = None
        super().__init__(data=data)
        self._skip_data_values = ['attrs']

    def initialize_values(self, data):
        super().initialize_values(data)
        self.attrs = [generate_variable(d) for d in (data.get('attrs') or [])]

    def json_schema(self):
        schema = super().json_schema()
        schema['additionalProperties'] = bool(self.additional_attrs)
        schema['properties']['attrs'] = {'type': 'array'}
        schema['required'].append('attrs')
        # We do not validate nested children and hence do not add it in the
        # json schema as it makes it very complex to handle all the possibilities
        return schema


class ListSchema(Schema):

    DEFAULT_TYPE = 'array'

    def __init__(self, data):
        self.items = []
        super().__init__(False, data=data)
        self._skip_data_values = ['items']

    def initialize_values(self, data):
        super().initialize_values(data)
        self.items = [generate_variable(d) for d in (data.get('items') or [])]

    def json_schema(self):
        schema = super().json_schema()
        schema['properties']['items'] = {'type': 'array'}
        schema['required'].append('items')
        return schema
