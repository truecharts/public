package gencmd

import (
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenPlain(command string, node string, extraFlags []string) []string {

    commands := []string{}
    //extraFlags = append(extraFlags, "--preserve")

    talosPath := embed.GetTalosExec()
    if node == "" {

        for _, noderef := range talassist.TalConfig.Nodes {
            // TODO add extraFlags
            cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress + " "
            commands = append(commands, cmd)
        }
    } else {
        cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + node + " "
        commands = append(commands, cmd)
    }
    return commands
}
