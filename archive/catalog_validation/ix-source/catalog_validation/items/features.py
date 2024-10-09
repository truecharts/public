SUPPORTED_FEATURES = {
    'normalize/interfaceConfiguration',
    'normalize/ixVolume',
    'definitions/certificate',
    'definitions/certificateAuthority',
    'definitions/interface',
    'definitions/gpuConfiguration',
    'definitions/timezone',
    'definitions/nodeIP',
    'validations/containerImage',
    'validations/nodePort',
    'validations/hostPath',
    'validations/lockedHostPath',
    'validations/hostPathAttachments',
}


def version_supported(version_details: dict) -> bool:
    return not bool(set(version_details['required_features']) - SUPPORTED_FEATURES)
