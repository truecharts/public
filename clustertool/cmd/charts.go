package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var chartsLongHelp = strings.TrimSpace(`
charttool was a tool to help you build TrueCharts Charts.
It has since been merged into Clustertool as "clustertool charts"

 Example commands
  > charttool bump 1.2.3 patch
  > charttool tagclean soemtag@somedigest

`)

var charts = &cobra.Command{
    Use:           "charts",
    Short:         "A tool to help with creating Talos cluster",
    Example:       "charttool bump 1.2.3 patch",
    Long:          chartsLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(charts)
}
