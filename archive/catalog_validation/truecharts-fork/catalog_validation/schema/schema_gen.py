from .attrs import (
    BooleanSchema, StringSchema, IntegerSchema, PathSchema, HostPathSchema, HostPathDirSchema,
    HostPathFileSchema, ListSchema, DictSchema, IPAddrSchema, CronSchema, URISchema
)


def get_schema(schema_data):
    schema = None
    if not isinstance(schema_data, dict):
        return schema

    s_type = schema_data.get('type')
    if s_type == 'boolean':
        schema = BooleanSchema
    elif s_type == 'string':
        schema = StringSchema
    elif s_type == 'int':
        schema = IntegerSchema
    elif s_type == 'path':
        schema = PathSchema
    elif s_type == 'hostpath':
        schema = HostPathSchema
    elif s_type == 'hostpathdirectory':
        schema = HostPathDirSchema
    elif s_type == 'hostpathfile':
        schema = HostPathFileSchema
    elif s_type == 'list':
        schema = ListSchema
    elif s_type == 'dict':
        schema = DictSchema
    elif s_type == 'ipaddr':
        schema = IPAddrSchema
    elif s_type == 'cron':
        schema = CronSchema
    elif s_type == 'uri':
        schema = URISchema

    if schema:
        schema = schema(data=schema_data)

    return schema
