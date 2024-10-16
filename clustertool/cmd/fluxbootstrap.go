package cmd

import (
	"github.com/spf13/cobra"
)

var fluxBootstrap = &cobra.Command{
	Use:   "fluxBootstrap",
	Short: "bootstrapFluxCD",
}

func init() {
	RootCmd.AddCommand(fluxBootstrap)
}
