package cmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/sops"
)

var advHealthLongHelp = strings.TrimSpace(`

`)

var health = &cobra.Command{
    Use:     "health",
    Short:   "Check Talos Cluster Health",
    Example: "clustertool adv health",
    Long:    advHealthLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        if err := sops.DecryptFiles(); err != nil {
            log.Info().Msgf("Error decrypting files: %v\n", err)
        }
        log.Info().Msg("Running Cluster HealthCheck")
        healthcmd := gencmd.GenHealth(helper.TalEnv["VIP_IP"])
        gencmd.ExecCmd(healthcmd)
    },
}

func init() {
    adv.AddCommand(health)
}
