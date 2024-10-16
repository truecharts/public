package cmd

import (
	"strings"

	"github.com/spf13/cobra"
	"github.com/truecharts/private/clustertool/pkg/initfiles"
	"github.com/truecharts/private/clustertool/pkg/sops"
)

var initLongHelp = strings.TrimSpace(`
ClusterTool requires a specific directory layout to ensure smooth operators and standardised environments.

To ensure smooth deployment, the init function can pre-generate all required files in the right places.
Afterwards you can edit talconfig.yaml and talenv.yaml to reflect your personal settings.

When done, please run clustertool genconfig to generate all configarion based on your personal settings

Powered by TalHelper (https://budimanjojo.github.io/talhelper/)

`)

var initFiles = &cobra.Command{
	Use:     "init",
	Short:   "generate Basic ClusterTool file-and-folder structure in current folder",
	Long:    initLongHelp,
	Example: "clustertool init",
	Run: func(cmd *cobra.Command, args []string) {

		sops.DecryptFiles()

		initfiles.InitFiles()
	},
}

func init() {
	RootCmd.AddCommand(initFiles)
}
