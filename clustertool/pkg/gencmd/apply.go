package gencmd

import (
    "path/filepath"

    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenApply(node string, extraFlags []string) []string {

    commands := []string{}
    //extraFlags = append(extraFlags, "--preserve")

    talosPath := embed.GetTalosExec()
    if node == "" {

        for _, noderef := range talassist.TalConfig.Nodes {
            // TODO add extraFlags
            filename := talassist.TalConfig.ClusterName + "-" + noderef.Hostname + ".yaml"
            cmd := talosPath + " " + "apply" + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress + " " + "--file=" + filepath.Join(helper.TalosGenerated, filename)
            commands = append(commands, cmd)
        }
    } else {
        cmd := talosPath + " " + "apply" + " --talosconfig " + helper.TalosConfigFile + " -n " + node + " "
        commands = append(commands, cmd)
    }
    return commands
}
