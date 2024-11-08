package cmd

import (
    "strings"

    "github.com/spf13/cobra"
    "github.com/truecharts/public/clustertool/pkg/gencmd"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

var advBootstrapLongHelp = strings.TrimSpace(`

`)

var bootstrap = &cobra.Command{
    Use:     "bootstrap",
    Short:   "bootstrap first Talos Node",
    Example: "clustertool talos bootstrap",
    Long:    advBootstrapLongHelp,
    Run:     bootstrapfunc,
}

func bootstrapfunc(cmd *cobra.Command, args []string) {
    if helper.GetYesOrNo("Do you want to also run the complete ClusterTool Bootstrap, besides just talos? (yes/no) [y/n]: ") {
        initfiles.LoadTalEnv(false)
        talassist.LoadTalConfig()
        gencmd.RunBootstrap(args)
    } else {
        bootstrapcmds := gencmd.GenPlain("bootstrap", talassist.TalConfig.Nodes[0].IPAddress, []string{})
        gencmd.ExecCmd(bootstrapcmds[0])
    }
}

func init() {
    talosCmd.AddCommand(bootstrap)
}
