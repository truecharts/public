package cmd

import (
    "strings"

    "github.com/spf13/cobra"
)

var scaleLongHelp = strings.TrimSpace(`
These are all advanced commands that should generally not be needed

`)

var scaleCmd = &cobra.Command{
    Use:           "scale",
    Short:         "Commands for handling TrueNAS SCALE",
    Long:          advLongHelp,
    SilenceUsage:  true,
    SilenceErrors: true,
}

func init() {
    RootCmd.AddCommand(scaleCmd)
}
