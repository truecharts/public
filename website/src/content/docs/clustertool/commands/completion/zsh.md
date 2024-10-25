---
title: completion zsh
---
## clustertool completion zsh

Generate the autocompletion script for zsh

### Synopsis

Generate the autocompletion script for the zsh shell.

If shell completion is not already enabled in your environment you will need
to enable it.  You can execute the following once:

    echo "autoload -U compinit; compinit" >> ~/.zshrc

To load completions in your current shell session:

    source <(clustertool completion zsh)

To load completions for every new session, execute once:

#### Linux:

    clustertool completion zsh > "${fpath[1]}/_clustertool"

#### macOS:

    clustertool completion zsh > $(brew --prefix)/share/zsh/site-functions/_clustertool

You will need to start a new shell for this setup to take effect.


```
clustertool completion zsh [flags]
```

### Options

```
  -h, --help              help for zsh
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
