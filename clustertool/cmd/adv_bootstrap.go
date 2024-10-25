package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
)

var advBootstrapLongHelp = strings.TrimSpace(`

`)

var bootstrap = &cobra.Command{
    Use:     "bootstrap",
    Short:   "bootstrap first Talos Node",
    Example: "clustertool adv bootstrap",
    Long:    advBootstrapLongHelp,
    Run:     bootstrapfunc,
}

func bootstrapfunc(cmd *cobra.Command, args []string) {
    gencmd.RunBootstrap(args)
}

func init() {
    adv.AddCommand(bootstrap)
}
