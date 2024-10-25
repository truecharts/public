package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var scaleLongHelp = strings.TrimSpace(`
These are all commands that are exclusively intended to migrate away from TrueNAS SCALE Kubernetes Apps to a normal kubernets cluster.

They will all, at a later date, be removed.

`)

var scaleCmd = &cobra.Command{
    Use:           "scale",
    Short:         "Commands for handling TrueNAS SCALE",
    Example:       "clustertool scale export",
    Long:          advLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(scaleCmd)
}
