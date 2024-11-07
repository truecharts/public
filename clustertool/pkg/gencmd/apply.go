package gencmd

import (
    "os"
    "path/filepath"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenApply(node string, extraArgs []string) []string {

    commands := []string{}

    talosPath := embed.GetTalosExec()
    if node == "" {

        for _, noderef := range talassist.TalConfig.Nodes {
            filename := talassist.TalConfig.ClusterName + "-" + noderef.Hostname + ".yaml"
            cmd := talosPath + " " + "apply machineconfig" + " -f " + filepath.Join(helper.TalosGenerated, filename) + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress // + " " + strings.Join(extraArgs, " ")
            commands = append(commands, cmd)
        }
    } else {
        nodename := ""
        for _, noderef := range talassist.TalConfig.Nodes {
            if noderef.IPAddress == node {
                nodename = noderef.Hostname
            }
        }
        if nodename == "" {
            log.Error().Msgf("Node IP %s, does not match any node in talconfig. Exiting...", node)
            os.Exit(1)
        }

        filename := talassist.TalConfig.ClusterName + "-" + nodename + ".yaml"
        cmd := talosPath + " " + "apply machineconfig" + " -f " + filepath.Join(helper.TalosGenerated, filename) + " --talosconfig " + helper.TalosConfigFile + " -n " + node // + " " + strings.Join(extraArgs, " ")
        commands = append(commands, cmd)
    }
    log.Debug().Msgf("Apply Commands rendered: %s", commands)
    return commands
}
