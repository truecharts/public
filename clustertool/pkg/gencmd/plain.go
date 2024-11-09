package gencmd

import (
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenPlain(command string, node string, extraArgs []string) []string {

    commands := []string{}

    talosPath := embed.GetTalosExec()
    if node == "" {

        for _, noderef := range talassist.TalConfig.Nodes {
            cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress + " " + strings.Join(extraArgs, " ")
            commands = append(commands, cmd)
        }
    } else {
        cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + node + " " + strings.Join(extraArgs, " ")
        commands = append(commands, cmd)
    }
    log.Debug().Msgf("%s Command rendered: %s", command, commands)
    return commands
}
