package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/info"
)

var infoLongHelp = strings.TrimSpace(`

`)

var infoCmd = &cobra.Command{
    Use:     "info",
    Short:   "Prints information about the clustertool binary",
    Long:    infoLongHelp,
    Example: "clustertool info",
    Run: func(cmd *cobra.Command, args []string) {
        info.NewInfo().Print()
    },
}

func init() {
    RootCmd.AddCommand(infoCmd)
}
