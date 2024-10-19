package cmd

import (
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
)

var bootstrap = &cobra.Command{
    Use:   "bootstrap",
    Short: "bootstrap first Talos Node",
    Run:   bootstrapfunc,
}

func bootstrapfunc(cmd *cobra.Command, args []string) {
    gencmd.RunBootstrap(args)
}

func init() {
    adv.AddCommand(bootstrap)
}
