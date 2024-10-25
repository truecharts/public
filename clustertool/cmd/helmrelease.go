package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var helmreleaseHelp = strings.TrimSpace(`
A toolkit to load helm-release files onto a cluster without flux.
originally created to make it easier to install/upgrade/edit flux-based clusterresources without flux
`)

var helmrelease = &cobra.Command{
    Use:           "helmrelease",
    Short:         "A toolkit to load helm-release files onto a cluster without flux",
    Example:       "clustertool helmrelease <install/upgrade>",
    Long:          advLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(helmrelease)
}
