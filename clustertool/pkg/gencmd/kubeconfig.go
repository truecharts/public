package gencmd

import (
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func GenKubeConfig(node string) string {
    talosPath := embed.GetTalosExec()
    strout := talosPath + " kubeconfig --talosconfig " + helper.TalosConfigFile + " -n " + node + " --force"
    return strout
}
