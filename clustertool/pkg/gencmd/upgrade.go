package gencmd

import (
    "io"
    "os"
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

// TODO: remove talhelper dependency for cmd creation
func GenUpgrade(node string, extraFlags []string) []string {
    // TODO: get rid of this, due to double uncontrollable log output

    upgradeStdout := os.Stdout
    r, w, _ := os.Pipe()
    os.Stdout = w
    extraFlags = append(extraFlags, "--preserve")
    err := generate.GenerateUpgradeCommand(talassist.TalConfig, helper.TalosGenerated, node, extraFlags)

    w.Close()
    out, _ := io.ReadAll(r)
    os.Stdout = upgradeStdout

    sliceOut := strings.Split(string(out), ";\n")
    talosPath := embed.GetTalosExec()
    var slice []string
    for _, str := range sliceOut {
        if str != "" {
            str = strings.ReplaceAll(str, "talosctl", talosPath)
            slice = append(slice, str)
        }

    }

    if err != nil {
        log.Fatal().Err(err).Msgf("failed to generate talosctl upgrade command: %s", err)
    }
    return slice
}

func GenKubeUpgrade(node string) string {
    talosPath := embed.GetTalosExec()
    strout := talosPath + " upgrade-k8s --talosconfig " + helper.TalosConfigFile + " -n " + node
    return strout
}
