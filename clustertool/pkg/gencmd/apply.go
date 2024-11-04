package gencmd

import (
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenApply(node string, extraFlags []string) []string {

    commands := []string{}
    //extraFlags = append(extraFlags, "--preserve")

    talosPath := embed.GetTalosExec()
    if node == "" {
        for _, nodeRef := range talassist.IpAddresses {
            talassist.LoadNodeIPs()
            // TODO add extraFlags

            // TODO: add images Refs
            // TODO: add schematic
            cmd := talosPath + " apply --talosconfig " + helper.TalosConfigFile + " -n " + nodeRef + " "
            commands = append(commands, cmd)
        }
    } else {
        cmd := talosPath + " apply --talosconfig " + helper.TalosConfigFile + " -n " + node + " "
        commands = append(commands, cmd)
    }
    return commands
}
