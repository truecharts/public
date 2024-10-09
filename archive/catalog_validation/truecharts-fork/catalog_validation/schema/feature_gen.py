def get_feature(feature):
    from .features import FEATURES
    if feature in FEATURES:
        return FEATURES[FEATURES.index(feature)]
