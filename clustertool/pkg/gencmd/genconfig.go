package gencmd

import (
    "bytes"
    "errors"
    "fmt"
    "os"
    "path"

    "github.com/rs/zerolog/log"

    talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
    "github.com/budimanjojo/talhelper/v3/pkg/generate"
    "github.com/budimanjojo/talhelper/v3/pkg/substitute"
    "github.com/budimanjojo/talhelper/v3/pkg/talos"
    sideroConfig "github.com/siderolabs/talos/pkg/machinery/config"
    "github.com/siderolabs/talos/pkg/machinery/config/generate/secrets"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
)

func GenConfig(args []string) error {
    initfiles.GenSchema()
    initfiles.GenTalEnvConfigMap()
    initfiles.CheckEnvVariables()
    genTalSecret()
    validateTalConfig(args)
    talhelperGenConfig()
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
        encoder := helper.YamlNewEncoder(buf)
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

    cfg, err := talhelperCfg.LoadAndValidateFromFile(helper.TalConfigFile, []string{helper.ClusterEnvFile}, false)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to parse TalConfig or talenv file: %s", err)
    }

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

    log.Info().Msgf("start loading and validating Talconfig file for cluster %s", helper.ClusterName)
    log.Debug().Msg(fmt.Sprintf("reading %s", cfg))
    cfgByte, err := os.ReadFile(cfg)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to read Talconfig file %s: %s", helper.TalConfigFile, err)
    }

    if err := substitute.LoadEnvFromFiles([]string{helper.ClusterEnvFile}); err != nil {
        log.Fatal().Err(err).Msg("failed to load env file: %s")
    }
    cfgByte, err = substitute.SubstituteEnvFromByte(cfgByte)
    if err != nil {
        log.Fatal().Err(err).Msg("failed trying to substitute env: %s")
    }

    log.Debug().Msg("Checking configfile after substitution...")

    errs, warns, err := talhelperCfg.ValidateFromByte(cfgByte)
    if err != nil {
        log.Fatal().Err(err).Msgf("failed to validate talhelper config file: %s", err)
    }

    if len(errs) > 0 {
        log.Trace().Msg("running talconfig validation errs...")
        log.Error().Msg("There are issues with your talhelper config file:")
        groupedErr := make(map[string][]string)
        for _, v := range errs {
            groupedErr[v.Field] = append(groupedErr[v.Field], v.Message.Error())
        }
        for field, list := range groupedErr {
            log.Error().Msgf("field: %q\n", field)
            for _, l := range list {
                log.Error().Msgf(l + "\n")
            }
        }
        os.Exit(1)
    } else if len(warns) > 0 {
        log.Trace().Msg("running talconfig validation warns...")
        log.Warn().Msg("There might be some issues with your talhelper config file:")
        groupedWarn := make(map[string][]string)
        for _, v := range warns {
            groupedWarn[v.Field] = append(groupedWarn[v.Field], v.Message)

        }
        for field, list := range groupedWarn {
            log.Warn().Msgf("field: %q\n", field)
            for _, l := range list {
                log.Warn().Msgf(l + "\n")
            }
        }
    } else {
        log.Info().Msg("Your talhelper config file is looking great!")
    }
    log.Info().Msg("Finished validating talconfig")
    return nil
}
