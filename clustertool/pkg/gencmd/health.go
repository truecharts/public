package gencmd

import (
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func GenHealth(node string) string {
    talosPath := embed.GetTalosExec()
    strout := talosPath + " health --talosconfig " + helper.TalosConfigFile + " -n " + node
    return strout
}
