package cmd

import (
    "path/filepath"
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
)

var hrUpgradeLongHelp = strings.TrimSpace(`

`)

var hrupgrade = &cobra.Command{
    Use:     "upgrade",
    Short:   "run helm-upgrade using a helm-release file without flux",
    Aliases: []string{"update", "edit"},
    Example: "clustertool helmrelease upgrade",
    Long:    hrUpgradeLongHelp,
    Run: func(cmd *cobra.Command, args []string) {
        initfiles.LoadTalEnv(false)

        var dir string

        // Check if args[0] includes a filename
        if filename := filepath.Base(args[0]); filename != "" && filename != "." && filename != "/" {
            dir = filepath.Dir(args[0])
        } else {
            dir = args[0] // Assuming args[0] is just a directory path without a filename
        }
        helmRepoPath := filepath.Join("./repositories", "helm")
        helmRepos, _ := fluxhandler.LoadAllHelmRepos(helmRepoPath)
        intermediateCharts := []fluxhandler.HelmChart{
            {dir, false, true},
        }

        fluxhandler.UpgradeCharts(intermediateCharts, helmRepos, false)
    },
}

func init() {
    helmrelease.AddCommand(hrupgrade)
}
