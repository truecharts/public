package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var advLongHelp = strings.TrimSpace(`
These are all advanced commands that should generally not be needed

`)

var adv = &cobra.Command{
    Use:           "adv",
    Short:         "Advanced cluster maintanence commands",
    Example:       "clustertool adv <bootstrap/health/precommit>",
    Long:          advLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(adv)
}
