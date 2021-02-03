def migrate(values):
    values['appVolumeMounts'] = {
        'transcode': {
            'hostPathEnabled': values['transcodeHostPathEnabled'],
            **({'hostPath': values['transcodeHostPath']} if values.get('transcodeHostPath') else {})
        },
        'config': {
            'hostPathEnabled': values['configHostPathEnabled'],
            **({'hostPath': values['configHostPath']} if values.get('configHostPath') else {})
        },
        'data': {
            'hostPathEnabled': values['dataHostPathEnabled'],
            **({'hostPath': values['dataHostPath']} if values.get('dataHostPath') else {})
        },
    }
    return values
