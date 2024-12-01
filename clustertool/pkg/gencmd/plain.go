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
    log.Debug().Msg("Generating plain CMDs...")
    if node == "" {
        log.Debug().Msg("Cmd Nodes is empty, rendering cmds for all nodes...")

        for _, noderef := range talassist.TalConfig.Nodes {
            log.Debug().Msgf("Rendering for node: %s", noderef)
            cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + noderef.IPAddress
            if len(extraArgs) == 0 {
                log.Debug().Msg("extraArgs is empty, not adding extra args to cmd")
            } else {
                log.Debug().Msgf("extraArgs not empty, adding extra args to cmd: %s", extraArgs)
                cmd = cmd + " " + strings.Join(extraArgs, " ")
            }
            commands = append(commands, cmd)
        }
    } else {
        log.Debug().Msgf("Rendering for single node: %s", node)
        cmd := talosPath + " " + command + " --talosconfig " + helper.TalosConfigFile + " -n " + node
        if len(extraArgs) == 0 {
            log.Debug().Msg("extraArgs is empty, not adding extra args to cmd")
        } else {
            log.Debug().Msgf("extraArgs not empty, adding extra args to cmd: %s", extraArgs)
            cmd = cmd + " " + strings.Join(extraArgs, " ")
        }

        commands = append(commands, cmd)
    }
    log.Debug().Msgf("%s Commands rendered: %s", command, commands)
    return commands
}
