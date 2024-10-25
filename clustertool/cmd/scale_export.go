package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/scale"
)

var scaleExportLongHelp = strings.TrimSpace(`

`)

var scaleexport = &cobra.Command{
    Use:     "export",
    Short:   "Export SCALE Apps to file",
    Example: "clustertool scale export",
    Long:    scaleExportLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        scale.ExportApps()
    },
}

func init() {
    scaleCmd.AddCommand(scaleexport)
}
