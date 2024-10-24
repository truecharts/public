package gencmd

import (
    "bytes"
    "errors"
    "fmt"
    "log/slog"
    "os"
    "path"

    "github.com/rs/zerolog/log"

    talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    "github.com/budimanjojo/talhelper/v3/pkg/substitute"
    "github.com/budimanjojo/talhelper/v3/pkg/talos"
    "github.com/fatih/color"
    sideroConfig "github.com/siderolabs/talos/pkg/machinery/config"
    "github.com/siderolabs/talos/pkg/machinery/config/generate/secrets"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "gopkg.in/yaml.v3"
)

func GenConfig(args []string) error {
    initfiles.GenSchema()
    initfiles.GenTalEnvConfigMap()
    initfiles.CheckEnvVariables()
    genTalSecret()
    validateTalConfig(args)
    talhelperGenConfig()
    validateTalConfig(args)
    initfiles.UpdateGitRepo()

    if err := fluxhandler.ProcessDirectory(path.Join(helper.ClusterPath, "kubernetes")); err != nil {
        log.Info().Msgf("Error: %v", err)
    }
    if err := fluxhandler.ProcessDirectory(path.Join(helper.ClusterPath, "kubernetes")); err != nil {
        log.Info().Msgf("Error: %v", err)
    } else {
        log.Info().Msgf("Kustomizations processed successfully.")
    }
    helper.CreateEncrPreCommitHook()
    log.Info().Msg("GenConfig: Completed Successfully!")
    return nil
}

func genTalSecret() error {

    log.Info().Msg("Generating TalSecret...")

    if _, err := os.Stat(helper.TalSecretFile); err == nil {

    } else if errors.Is(err, os.ErrNotExist) {
        os.MkdirAll(helper.TalosGenerated, os.ModePerm)
        outfile, err := os.Create(helper.TalSecretFile)
        if err != nil {
            panic(err)
        }
        defer outfile.Close()

        var s *secrets.Bundle
        version, _ := sideroConfig.ParseContractFromVersion(talhelperCfg.LatestTalosVersion)
        s, err = talos.NewSecretBundle(secrets.NewClock(), *version)
        if err != nil {
            return err
        }

        buf := new(bytes.Buffer)
        encoder := yaml.NewEncoder(buf)
        encoder.SetIndent(2)

        err = encoder.Encode(s)

        if err != nil {
            return err
        }

        _, err = outfile.Write(buf.Bytes())
        if err != nil {
            // Handle the error
            panic(err)
        }

        return nil

    } else {

    }
    return nil
}

func talhelperGenConfig() error {
    genconfigTalosMode := "metal"
    genconfigNoGitignore := false
    genconfigDryRun := false
    genconfigOfflineMode := false

    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, true)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to parse TalConfig or talenv file: %s", err)
    }
    log.Info().Msg("Start Generating Config File...")

    err = generate.GenerateConfig(cfg, genconfigDryRun, helper.TalosGenerated, helper.TalSecretFile, genconfigTalosMode, genconfigOfflineMode)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to generate talos config: %s", err)
    }

    if !genconfigNoGitignore && !genconfigDryRun {
        err = cfg.GenerateGitignore(helper.TalosGenerated)
        if err != nil {
            log.Fatal().Err(err).Msgf("failed to generate gitignore file: %s", err)
        }
    }
    return nil
}

func validateTalConfig(argsInt []string) error {
    cfg := helper.TalConfigFile
    validateTHNoSubstitute := false
    args := []string{}
    if len(args) > 0 {
        cfg = args[0]
    }

    log.Info().Msg("start loading and validating config file")
    slog.Debug(fmt.Sprintf("reading %s", cfg))
    cfgByte, err := os.ReadFile(cfg)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to read config file: %s", err)
    }

    if !validateTHNoSubstitute {
        if err := substitute.LoadEnvFromFiles([]string{helper.ClusterEnvFile}); err != nil {
            log.Fatal().Err(err).Msg("failed to load env file: %s")
        }
        cfgByte, err = substitute.SubstituteEnvFromByte(cfgByte)
        if err != nil {
            log.Fatal().Err(err).Msg("failed trying to substitute env: %s")
        }
    }

    errs, warns, err := talhelperCfg.ValidateFromByte(cfgByte)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to validate talhelper config file: %s", err)
    }

    if len(errs) > 0 || len(warns) > 0 {
        color.Red("There are issues with your talhelper config file:")
        grouped := make(map[string][]string)
        for _, v := range errs {
            grouped[v.Field] = append(grouped[v.Field], v.Message.Error())
        }
        for _, v := range warns {
            grouped[v.Field] = append(grouped[v.Field], v.Message)
        }
        for field, list := range grouped {
            color.Yellow("field: %q\n", field)
            for _, l := range list {
                log.Info().Msgf(l + "\n")
            }
        }
    } else {
        log.Info().Msg("Your talhelper config file is looking great!")
    }
    return nil
}
