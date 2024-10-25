package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/info"
)

var infoLongHelp = strings.TrimSpace(`
clustertool is a tool to help you easily deploy and maintain a Talos Kubernetes Cluster.


Workflow:
  Create talconfig.yaml file defining your nodes information like so:

 Available commands
  > clustertool init
  > clustertool genconfig

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
