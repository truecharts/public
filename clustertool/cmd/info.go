package cmd

import (
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/info"
)

var infoCmd = &cobra.Command{
	Use:     "info",
	Short:   "Prints information about the clustertool binary",
	Example: "clustertool info",
	Run: func(cmd *cobra.Command, args []string) {
		info.NewInfo().Print()
	},
}

func init() {
	RootCmd.AddCommand(infoCmd)
}
