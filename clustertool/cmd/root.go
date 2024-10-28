package cmd

import (
    "os"
    "path/filepath"

    "github.com/rs/zerolog/log"
    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var thisversion string

var RootCmd = &cobra.Command{
    Use:           "clustertool",
    Short:         "A tool to help with creating Talos cluster",
    Long:          infoLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
    Version:       thisversion,
}

func init() {
    // Define the --cluster flag
    RootCmd.PersistentFlags().StringVar(&helper.ClusterName, "cluster", "main", "Cluster name")
}

func Execute() error {
    // Parse only the persistent flags (like --cluster) before executing any command
    RootCmd.PersistentFlags().Parse(os.Args[1:])

    // You can now access the helper.ClusterName variable
    if helper.ClusterName != "" {
        log.Info().Msgf("Cluster name: %s\n", helper.ClusterName)
        helper.ClusterPath = filepath.Join("./clusters", helper.ClusterName)
        helper.ClusterEnvFile = filepath.Join(helper.ClusterPath, "/clusterenv.yaml")
        helper.TalConfigFile = filepath.Join(helper.ClusterPath, "/talos", "talconfig.yaml")
        helper.TalosPath = filepath.Join(helper.ClusterPath, "/talos")
        helper.KubernetesPath = filepath.Join(helper.ClusterPath, "/kubernetes")
        helper.TalosGenerated = filepath.Join(helper.TalosPath, "/generated")
        helper.TalosConfigFile = filepath.Join(helper.TalosGenerated, "talosconfig")
        helper.TalSecretFile = filepath.Join(helper.TalosGenerated, "talsecret.yaml")
    }

    // Execute the root command and all subcommands
    return RootCmd.Execute()
}
