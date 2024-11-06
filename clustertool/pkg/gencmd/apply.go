package gencmd

import (
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenApply(node string, extraArgs []string) []string {

    commands := []string{}
    //extraFlags = append(extraFlags, "--preserve")

    talosPath := embed.GetTalosExec()
    if node == "" {

        for _, noderef := range talassist.TalConfig.Nodes {
            // TODO add extraFlags
            filename := talassist.TalConfig.ClusterName + "-" + noderef.Hostname + ".yaml"
            cmd := talosPath + " " + "apply-config" + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress + " -f " + filepath.Join(helper.TalosGenerated, filename) + " " + strings.Join(extraArgs, " ")
            commands = append(commands, cmd)
        }
    } else {
        cmd := talosPath + " " + "apply-config" + " --talosconfig " + helper.TalosConfigFile + " -n " + node + " " + strings.Join(extraArgs, " ")
        commands = append(commands, cmd)
    }
    log.Debug().Msgf("Apply Commands rendered: %s", commands)
    return commands
}
