package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var talosLongHelp = strings.TrimSpace(`
These are all commands that can be used to maintain Talos OS

`)

var talosCmd = &cobra.Command{
    Use:           "talos",
    Short:         "Commands for handling Talos OS",
    Example:       "clustertool talos apply",
    Long:          advLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(talosCmd)
}
