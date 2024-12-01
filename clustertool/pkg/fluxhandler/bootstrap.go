package fluxhandler

import (
    "context"
    "os"
    "path/filepath"

    "github.com/rs/zerolog"
    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/kubectlcmds"
)

func init() {
    // Configure zerolog to output to stdout with a timestamp and log level
    log.Logger = log.Output(zerolog.ConsoleWriter{Out: os.Stdout}).With().Timestamp().Logger()
}

// FluxBootstrap initializes the FluxCD bootstrapping process if GITHUB_REPOSITORY is set in TalEnv.
func FluxBootstrap(ctx context.Context) {

    if helper.TalEnv["GITHUB_REPOSITORY"] != "" {
        log.Info().Msg("GITHUB_Repository for Flux configured.")
        if helper.GetYesOrNo("Do you want to (re)bootstrap FluxCD as well? (yes/no) [y/n]: ") {
            if err := bootstrapFluxCD(ctx); err != nil {
                log.Fatal().Err(err).Msg("Error during FluxCD bootstrap")
                if helper.GetYesOrNo("Do you want to retry? (yes/no) [y/n]: ") {
                    if err2 := bootstrapFluxCD(ctx); err2 != nil {
                        log.Fatal().Err(err2).Msg("Error during FluxCD bootstrap")
                    }
                }
            }
            log.Info().Msg("FluxCD Bootstrapped successfully")
        }
    }
}

// bootstrapFluxCD handles the entire FluxCD bootstrapping process.
func bootstrapFluxCD(ctx context.Context) error {
    if err := checkGitRepo(); err != nil {
        return err
    }

    fluxPath := filepath.Join(helper.ClusterPath, "kubernetes", "flux-system", "flux")
    if err := setupFluxCD(ctx, fluxPath); err != nil {
        return err
    }

    reposFilePath := "repositories"
    if err := setupRepositories(ctx, reposFilePath); err != nil {
        return err
    }

    clusterEntryFile := filepath.Join(helper.ClusterPath, "kubernetes", "flux-entry.yaml")
    if err := kubectlcmds.KubectlApply(ctx, clusterEntryFile); err != nil {
        log.Error().Err(err).Str("path", clusterEntryFile).Msg("Error applying Kubernetes flux-entry manifest")
        return err
    }

    return nil
}

// checkGitRepo verifies if the current directory is a valid Git repository.
func checkGitRepo() error {
    isRepo, err := helper.IsCurrentDirGitRepo()
    if err != nil {
        log.Error().Err(err).Msg("Error checking Git repository")
        return err
    }
    if !isRepo {
        errMsg := "Bootstrap: ERROR The current directory is not a Git repository. Cannot bootstrap fluxcd"
        log.Error().Msg(errMsg)
        return err
    }
    log.Info().Msg("Bootstrap: The current directory is a valid GIT repository, continuing...")
    return nil
}

// setupFluxCD handles the setup of FluxCD manifests.
func setupFluxCD(ctx context.Context, fluxPath string) error {
    bootstrapFile := "bootstrap.yaml.ct"
    kustomFile := "kustomization.yaml"
    tmpFile := "placeholder"

    log.Info().Msg("Bootstrap: Loading fluxcd onto the cluster...")

    // Rename files for kustomize application
    if err := os.Rename(filepath.Join(fluxPath, kustomFile), filepath.Join(fluxPath, tmpFile)); err != nil {
        log.Error().Err(err).Msg("Error renaming kustomization file")
        return err
    }
    if err := os.Rename(filepath.Join(fluxPath, bootstrapFile), filepath.Join(fluxPath, kustomFile)); err != nil {
        log.Error().Err(err).Msg("Error renaming bootstrap file")
        return err
    }

    if err := kubectlcmds.KubectlApplyKustomize(ctx, fluxPath); err != nil {
        log.Error().Err(err).Str("path", fluxPath).Msg("Error applying FluxCD manifest")
        log.Debug().Msg("Reverting renamed files for fluxbootstrap")
        if err := os.Rename(filepath.Join(fluxPath, kustomFile), filepath.Join(fluxPath, bootstrapFile)); err != nil {
            log.Error().Err(err).Msg("Error renaming kustomization file back after previous error")
            return err
        }
        if err := os.Rename(filepath.Join(fluxPath, tmpFile), filepath.Join(fluxPath, kustomFile)); err != nil {
            log.Error().Err(err).Msg("Error renaming placeholder file after previous back")
            return err
        }
        return err
    }

    // Revert file renames
    if err := os.Rename(filepath.Join(fluxPath, kustomFile), filepath.Join(fluxPath, bootstrapFile)); err != nil {
        log.Error().Err(err).Msg("Error renaming kustomization file back")
        return err
    }
    if err := os.Rename(filepath.Join(fluxPath, tmpFile), filepath.Join(fluxPath, kustomFile)); err != nil {
        log.Error().Err(err).Msg("Error renaming placeholder file back")
        return err
    }

    return nil
}

// setupRepositories handles the setup of repository manifests.
func setupRepositories(ctx context.Context, reposFilePath string) error {
    log.Info().Msg("Bootstrap: Loading git-repo manifests onto the cluster...")

    gitRepoFile := filepath.Join(reposFilePath, "git", "this-repo.yaml")
    if err := kubectlcmds.KubectlApply(ctx, gitRepoFile); err != nil {
        log.Error().Err(err).Str("path", reposFilePath).Msg("Error applying repositories manifest")
        return err
    }

    log.Info().Msg("Bootstrap: Loading repositories flux-entry onto the cluster...")
    reposEntryFile := filepath.Join(reposFilePath, "flux-entry.yaml")
    if err := kubectlcmds.KubectlApply(ctx, reposEntryFile); err != nil {
        log.Error().Err(err).Str("path", reposEntryFile).Msg("Error applying repositories flux-entry manifest")
        return err
    }

    return nil
}
