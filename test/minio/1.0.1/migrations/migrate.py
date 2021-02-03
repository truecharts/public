def migrate(values):
    values.update({
        'appVolumeMounts': {
            'export': {
                'hostPathEnabled': values['minioHostPathEnabled'],
                **({'hostPath': values['minioHostPath']} if values.get('minioHostPath') else {})
            },
        },
    })
    return values
