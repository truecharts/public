package cmd

import (
	"os"
	"path/filepath"
	"strings"

	"github.com/rs/zerolog/log"
	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/helper"
)

var thisversion string

var rootLongHelp = strings.TrimSpace(`
clustertool is a tool to help you easily deploy and maintain a Talos Kubernetes Cluster.


Workflow:
  Create talconfig.yaml file defining your nodes information like so:

 Available commands
  > clustertool init
  > clustertool genconfig

  Powered by TalHelper (https://budimanjojo.github.io/talhelper/)

`)

var RootCmd = &cobra.Command{
	Use:           "clustertool",
	Short:         "A tool to help with creating Talos cluster",
	Long:          rootLongHelp,
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
		helper.TalosGenerated = filepath.Join(helper.TalosPath, "/generated")
		helper.TalosConfigFile = filepath.Join(helper.TalosGenerated, "talosconfig")
		helper.TalSecretFile = filepath.Join(helper.TalosGenerated, "talsecret.yaml")
	}

	// Execute the root command and all subcommands
	return RootCmd.Execute()
}
