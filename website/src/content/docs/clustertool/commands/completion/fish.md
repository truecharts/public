---
title: completion fish
---
## clustertool completion fish

Generate the autocompletion script for fish

### Synopsis

Generate the autocompletion script for the fish shell.

To load completions in your current shell session:

    clustertool completion fish | source

To load completions for every new session, execute once:

    clustertool completion fish > ~/.config/fish/completions/clustertool.fish

You will need to start a new shell for this setup to take effect.


```
clustertool completion fish [flags]
```

### Options

```
  -h, --help              help for fish
      --no-descriptions   disable completion descriptions
```

### Options inherited from parent commands

```
      --cluster string   Cluster name (default "main")
```
