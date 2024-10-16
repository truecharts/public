package cmd

import (
	"strings"

	"github.com/spf13/cobra"
)

var helmreleaseHelp = strings.TrimSpace(`
A toolkit to load helm-release files onto a cluster without flux

`)

var helmrelease = &cobra.Command{
	Use:           "helmrelease",
	Short:         "A toolkit to load helm-release files onto a cluster without flux",
	Long:          advLongHelp,
	SilenceUsage:  true,
	SilenceErrors: true,
}

func init() {
	RootCmd.AddCommand(helmrelease)
}
