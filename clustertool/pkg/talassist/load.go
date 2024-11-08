package talassist

import (
    "encoding/json"
    "os"
    "path"

    talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    talhelperTalos "github.com/budimanjojo/talhelper/v3/pkg/talos"
    "github.com/invopop/jsonschema"
    "github.com/rs/zerolog/log"
    sideroConfig "github.com/siderolabs/talos/pkg/machinery/config"
    "github.com/siderolabs/talos/pkg/machinery/config/generate/secrets"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

var (
    TalConfig          *talhelperCfg.TalhelperConfig
    LatestTalosVersion string
)

func LoadTalConfig() {
    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, false)
    if err != nil {
        log.Fatal().Err(err).Msg("failed to parse talconfig or talenv file: %s")
    }
    TalConfig = cfg
    LatestTalosVersion = talhelperCfg.LatestTalosVersion
    return
}

func GenSchema() error {
    cfg := talhelperCfg.TalhelperConfig{}
    r := new(jsonschema.Reflector)
    r.FieldNameTag = "yaml"
    r.RequiredFromJSONSchemaTags = true
    os.MkdirAll(helper.ClusterPath+"/talos", os.ModePerm)
    var genschemaFile = path.Join(helper.ClusterPath, "/talos/talconfig.json")

    schema := r.Reflect(&cfg)
    data, _ := json.MarshalIndent(schema, "", "  ")
    if err := os.WriteFile(genschemaFile, data, os.FileMode(0o644)); err != nil {
        log.Fatal().Err(err).Msg("failed to write file to %s: %v")
    }
    return nil
}

func NewSecretBundle() *secrets.Bundle {
    version, _ := sideroConfig.ParseContractFromVersion(LatestTalosVersion)
    s, err := talhelperTalos.NewSecretBundle(secrets.NewClock(), *version)
    if err != nil {
        log.Error().Msgf("Error loading secret bundle %s", err)
    }
    return s
}

func TalhelperGenConfig() error {
    genconfigTalosMode := "metal"
    genconfigNoGitignore := false
    genconfigDryRun := false
    genconfigOfflineMode := false

    err := generate.GenerateConfig(TalConfig, genconfigDryRun, helper.TalosGenerated, helper.TalSecretFile, genconfigTalosMode, genconfigOfflineMode)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to generate talos config: %s", err)
    }

    if !genconfigNoGitignore && !genconfigDryRun {
        err = TalConfig.GenerateGitignore(helper.TalosGenerated)
        if err != nil {
            log.Fatal().Err(err).Msgf("failed to generate gitignore file: %s", err)
        }
    }
    return nil
}
