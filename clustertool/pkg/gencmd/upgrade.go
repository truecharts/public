package gencmd

import (
    "io"
    "os"
    "strings"

    "github.com/rs/zerolog/log"

    talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func GenUpgrade(node string, extraFlags []string) []string {
    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, false)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to parse talconfig or talenv file: %s", err)
    }

    upgradeStdout := os.Stdout
    r, w, _ := os.Pipe()
    os.Stdout = w
    extraFlags = append(extraFlags, "--preserve")
    err = generate.GenerateUpgradeCommand(cfg, helper.TalosGenerated, node, extraFlags)

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
