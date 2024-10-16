package cmd

import (
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/scale"
)

var scaleexport = &cobra.Command{
	Use:   "scaleexport",
	Short: "Export SCALE Apps to file",
	Run: func(cmd *cobra.Command, args []string) {
		scale.ExportApps()
	},
}

func init() {
	adv.AddCommand(scaleexport)
}
