# Values.yaml Files

Values.yaml files generally always contain configuration setting for Helm charts, TrueCharts is no different.
However, we have multiple different values.yaml files, with different goals. Because TrueNAS SCALE just works slightly differently from standard Helm Charts

### The Files

##### values.yaml

The normal file with default setting in helm charts. However, for our non-library and non-dependency charts, this is not used for TrueCharts. As questions.yaml generates configs on demand (with addition of ix_values.yaml), this file might interfere with some Helm operations combined with the questions.yaml or test_values.yaml systems or cause unexpected behavior if used.

##### ix_values.yaml

This file contains config values that are not included in questions.yaml, but should be copied into the resulting configuration anyway. It's mostly used to ensure setting can be changed by the maintainer with every update, such as versions, which is not possible when setting things as defaults inside questions.yaml

This file is, however, not very well checked by validation and CI. Use it when you absolutely have to.


##### test_values.yaml

Our Apps often use special features of TrueNAS inside questions.yaml and our charts. However these features are not (always) compatible with stock Helm. Therefore we define a set of seperate "test" values.yaml setting that get used when we run the test CI.

They should, however, be as close as possible to your "actual" default settings in questions.yaml

##### default_values.yaml

This on is the "odd one" of the bunch. We prefer not to use it for actual default, but to store default when porting charts from upstream.
