package cmd

import (
	"context"

	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/fluxhandler"
)

var fluxbootstrap = &cobra.Command{
	Use:   "fluxbootstrap",
	Short: "Manually bootstrap fluxcd on existing cluster",
	Run: func(cmd *cobra.Command, args []string) {
		ctx := context.Background()
		fluxhandler.FluxBootstrap(ctx)
	},
}

func init() {
	adv.AddCommand(fluxbootstrap)
}
