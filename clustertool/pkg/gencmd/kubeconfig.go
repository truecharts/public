package gencmd

import (
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func GenKubeConfig(node string, extraFlags []string) string {

    //extraFlags = append(extraFlags, "--preserve")
    talosPath := embed.GetTalosExec()
    cmd := talosPath + " kubeconfig --talosconfig " + helper.TalosConfigFile + " -n " + node + " "

    return cmd
}
