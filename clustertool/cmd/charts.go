package cmd

import (
	"strings"

	"github.com/spf13/cobra"
)

var chartsLongHelp = strings.TrimSpace(`
charttool is a tool to help you build TrueCharts Charts

Workflow:
  Create talconfig.yaml file defining your nodes information like so:

 Available commands
  > charttool bump 1.2.3 patch
  > charttool tagclean soemtag@somedigest

`)

var charts = &cobra.Command{
	Use:           "charts",
	Short:         "A tool to help with creating Talos cluster",
	Long:          chartsLongHelp,
	SilenceUsage:  true,
	SilenceErrors: true,
}

func init() {
	RootCmd.AddCommand(charts)
}
