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
    "github.com/truecharts/public/clustertool/pkg/initfiles"
)

func GenApply(node string, extraFlags []string) []string {
    initfiles.LoadTalEnv(false)
    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, false)
    if err != nil {
        log.Fatal().Err(err).Msg("failed to parse talconfig or talenv file: %s")
    }

    applyStdout := os.Stdout
    r, w, _ := os.Pipe()
    os.Stdout = w

    err = generate.GenerateApplyCommand(cfg, helper.TalosGenerated, node, extraFlags)

    w.Close()
    out, _ := io.ReadAll(r)
    os.Stdout = applyStdout

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
        log.Fatal().Err(err).Msg("failed to generate talosctl apply command: %s")
    }
    return slice
}
