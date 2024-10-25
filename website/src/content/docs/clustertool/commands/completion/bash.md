---
title: completion bash
---
## clustertool completion bash

Generate the autocompletion script for bash

### Synopsis

Generate the autocompletion script for the bash shell.

This script depends on the 'bash-completion' package.
If it is not installed already, you can install it via your OS's package manager.

To load completions in your current shell session:

    source <(clustertool completion bash)

To load completions for every new session, execute once:

#### Linux:

    clustertool completion bash > /etc/bash_completion.d/clustertool

#### macOS:

    clustertool completion bash > $(brew --prefix)/etc/bash_completion.d/clustertool

You will need to start a new shell for this setup to take effect.


```
clustertool completion bash
```

### Options

```
  -h, --help              help for bash
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
