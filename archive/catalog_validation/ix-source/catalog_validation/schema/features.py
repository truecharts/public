from catalog_validation.exceptions import ValidationErrors

from .schema_gen import DictSchema, IntegerSchema, StringSchema


class Feature:

    NAME = NotImplementedError
    VALID_SCHEMAS = []

    def __str__(self):
        return self.NAME

    def validate(self, schema_obj, schema_str):
        verrors = ValidationErrors()
        if not isinstance(schema_obj, tuple(self.VALID_SCHEMAS)):
            verrors.add(
                f'{schema_str}.type',
                f'Schema must be one of {", ".join(str(v) for v in self.VALID_SCHEMAS)} schema types'
            )

        if not verrors:
            self._validate(verrors, schema_obj, schema_str)
        verrors.check()

    def _validate(self, verrors, schema_obj, schema_str):
        pass

    def __eq__(self, other):
        return self.NAME == (other if isinstance(other, str) else other.NAME)


class IXVolumeFeature(Feature):

    NAME = 'normalize/ixVolume'
    VALID_SCHEMAS = [DictSchema, StringSchema]

    def _validate(self, verrors, schema_obj, schema_str):
        if isinstance(schema_obj, StringSchema):
            return

        attrs = schema_obj.attrs
        if 'datasetName' not in attrs:
            verrors.add(f'{schema_str}.attrs', 'Variable "datasetName" must be specified.')
        elif not isinstance(attrs[attrs.index('datasetName')].schema, StringSchema):
            verrors.add(f'{schema_str}.attrs', 'Variable "datasetName" must be of string type.')

        if 'aclEntries' in attrs and not isinstance(attrs[attrs.index('aclEntries')].schema, DictSchema):
            verrors.add(f'{schema_str}.attrs', 'Variable "aclEntries" must be of dict type.')

        if 'properties' in attrs:
            index = attrs.index('properties')
            properties = attrs[index]
            properties_schema = properties.schema
            supported_props = {
                'recordsize': {
                    'valid_schema_type': [StringSchema],
                },
            }
            not_supported = set([str(v) for v in properties_schema.attrs]) - set(supported_props)
            if not_supported:
                verrors.add(
                    f'{schema_str}.attrs.{index}.attrs', f'{", ".join(not_supported)} properties are not supported'
                )

            for prop_index, prop in enumerate(properties_schema.attrs):
                if prop.name not in supported_props:
                    continue

                prop_schema = prop.schema
                check_prop = supported_props[prop.name]
                if not isinstance(prop_schema, tuple(check_prop['valid_schema_type'])):
                    verrors.add(
                        f'{schema_str}.attrs.{index}.attrs.{prop_index}',
                        f'{prop.name!r} must be of '
                        f'{", ".join([str(s) for s in check_prop["valid_schema_type"]])} type(s)'
                    )


class NormalizeInterfaceConfiguration(Feature):
    NAME = 'normalize/interfaceConfiguration'
    VALID_SCHEMAS = [DictSchema]


class DefinitionInterfaceFeature(Feature):

    NAME = 'definitions/interface'
    VALID_SCHEMAS = [StringSchema]


class DefinitionGPUConfigurationFeature(Feature):

    NAME = 'definitions/gpuConfiguration'
    VALID_SCHEMAS = [DictSchema]


class DefinitionTimezoneFeature(Feature):

    NAME = 'definitions/timezone'
    VALID_SCHEMAS = [StringSchema]


class DefinitionNodeIPFeature(Feature):

    NAME = 'definitions/nodeIP'
    VALID_SCHEMAS = [StringSchema]


class ValidationNodePortFeature(Feature):

    NAME = 'validations/nodePort'
    VALID_SCHEMAS = [IntegerSchema]


class CertificateFeature(Feature):

    NAME = 'definitions/certificate'
    VALID_SCHEMAS = [IntegerSchema]


class CertificateAuthorityFeature(Feature):

    NAME = 'definitions/certificateAuthority'
    VALID_SCHEMAS = [IntegerSchema]


class ContainerImageFeature(Feature):

    NAME = 'validations/containerImage'
    VALID_SCHEMAS = [DictSchema]

    def _validate(self, verrors, schema_obj, schema_str):
        attrs = schema_obj.attrs
        for check_attr in ('repository', 'tag'):
            if check_attr not in attrs:
                verrors.add(f'{schema_str}.attrs', f'Variable {check_attr!r} must be specified.')
            elif not isinstance(attrs[attrs.index(check_attr)].schema, StringSchema):
                verrors.add(f'{schema_str}.attrs', f'Variable {check_attr!r} must be of string type.')


class ACLFeature(Feature):

    NAME = 'normalize/acl'
    VALID_SCHEMAS = [DictSchema]


FEATURES = [
    ACLFeature(),
    IXVolumeFeature(),
    DefinitionInterfaceFeature(),
    DefinitionGPUConfigurationFeature(),
    DefinitionTimezoneFeature(),
    DefinitionNodeIPFeature(),
    ValidationNodePortFeature(),
    CertificateFeature(),
    CertificateAuthorityFeature(),
    ContainerImageFeature(),
]
