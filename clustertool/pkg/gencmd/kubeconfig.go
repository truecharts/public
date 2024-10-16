package gencmd

import (
	"github.com/truecharts/private/clustertool/embed"
	"github.com/truecharts/private/clustertool/pkg/helper"
)

func GenKubeConfig(node string) string {
	talosPath := embed.GetTalosExec()
	strout := talosPath + " kubeconfig --talosconfig " + helper.TalosConfigFile + " -n " + node + " --force"
	return strout
}
