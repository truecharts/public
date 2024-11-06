package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
)

var advTestCmdlongHelp = strings.TrimSpace(`
This command is mostly just for development usage and should NEVER be used by end-users.
`)

var testcmd = &cobra.Command{
    Use:   "test",
    Short: "tests specific code for developer usages",
    Long:  advTestCmdlongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        initfiles.LoadTalEnv(false)
        // err := fluxhandler.ProcessJSONFiles("./testdata/truenas_exports")
        // if err != nil {
        //  log.Info().Msg("Error:", err)
        // }
    },
}

func init() {
    adv.AddCommand(testcmd)
}
