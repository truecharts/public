package gencmd

import (
    "bytes"
    "errors"
    "os"
    "path"

    "github.com/rs/zerolog/log"

    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/initfiles"
    "github.com/truecharts/public/clustertool/pkg/sops"
    "github.com/truecharts/public/clustertool/pkg/talassist"
)

func GenConfig(args []string) error {
    if initfiles.CheckRunAgainFileExists() {
        log.Fatal().Msg("You need to re-run Init. Exiting...")
        os.Exit(1)
    }
    if err := sops.DecryptFiles(); err != nil {
        log.Info().Msgf("Error decrypting files: %v\n", err)
    }
    talassist.LoadTalConfig()
    talassist.GenSchema()
    initfiles.GenTalEnvConfigMap()
    initfiles.CheckEnvVariables()
    genTalSecret()
    talassist.TalhelperGenConfig()
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
    log.Info().Msg("Running TalSecret check-and-create...")
    if _, err := os.Stat(helper.TalSecretFile); err == nil {
        log.Debug().Msg("TalSecret already exists, skipping...")
    } else if errors.Is(err, os.ErrNotExist) {
        log.Info().Msg("Generating TalSecret...")
        os.MkdirAll(helper.TalosGenerated, os.ModePerm)
        outfile, err := os.Create(helper.TalSecretFile)
        if err != nil {
            panic(err)
        }
        defer outfile.Close()

        secretbundle := talassist.NewSecretBundle()

        buf := new(bytes.Buffer)
        encoder := helper.YamlNewEncoder(buf)
        encoder.SetIndent(2)

        err = encoder.Encode(secretbundle)

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
