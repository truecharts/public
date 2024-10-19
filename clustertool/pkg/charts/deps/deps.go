package deps

import (
    "fmt"
    "io"
    "net/http"
    "os"
    "path"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/truecharts/public/clustertool/pkg/charts/chartFile"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func LoadGPGKey() error {
    log.Info().Msg("🔑 Fetching and Loading TrueCharts PGP Public Key 🔑")
    if err := os.MkdirAll(helper.GpgDir, os.ModePerm); err != nil {
        log.Fatal().Err(err).Msg("❌ Failed to create GPG directory")
    }

    keybaseURL := "https://truecharts.org/pub_key.gpg"
    pubringPath := path.Join(helper.GpgDir, "pubring.gpg")
    if err := downloadFile(keybaseURL, pubringPath); err != nil {
        log.Fatal().Err(err).Msg("❌ Failed to download keybase public key")
    }

    certmanURL := "https://cert-manager.io/public-keys/cert-manager-keyring-2021-09-20-1020CF3C033D4F35BAE1C19E1226061C665DF13E.gpg"
    certmanPath := path.Join(helper.GpgDir, "certman.gpg")
    if err := downloadFile(certmanURL, certmanPath); err != nil {
        log.Fatal().Err(err).Msg("❌ Failed to download certman public key")
    }

    log.Info().Msg("✅ Public Key loaded successfully")
    return nil
}

func downloadFile(url, destination string) error {
    response, err := http.Get(url)
    if err != nil {
        log.Error().Err(err).Msgf("❌ Failed to download [%s]", url)
        return err
    }
    defer response.Body.Close()

    body, err := io.ReadAll(response.Body)
    if err != nil {
        log.Error().Err(err).Msg("❌ Failed to read response body")
        return err
    }

    err = os.WriteFile(destination, body, os.ModePerm)
    if err != nil {
        log.Error().Err(err).Msgf("❌ Failed to write file at [%s]", destination)
        return err
    }

    return nil
}

// fetchIndexFile downloads an index file from a repo if not already cached
func fetchIndexFile(repo string, repoDir string, repoURL string) error {
    destPath := path.Join(helper.IndexCache, repoDir, "index.yaml")
    if strings.HasPrefix(repoURL, "oci") {
        log.Info().Msgf("⏩ URL [%s] is OCI, skipping index download", repoURL)
        return nil
    }

    if _, err := os.Stat(destPath); err == nil {
        log.Info().Msgf("✅ Index file for [%s] already cached", repo)
        return nil
    }

    log.Info().Msgf("🙅 Index file for [%s] not cached", repo)

    // Create index directory
    err := os.MkdirAll(path.Join(helper.IndexCache, repoDir), os.ModePerm)
    if err != nil {
        log.Fatal().Err(err).Msg("❌ Failed to create index directory")
    }

    // Download index file
    log.Info().Msgf("⏬ Downloading index [%s]...", repoURL)
    err = downloadFile(repoURL, destPath)
    if err != nil {
        log.Fatal().Err(err).Msgf("❌ Failed to download index for [%s] from [%s]", repo, repoURL)
    }

    log.Info().Msg("✅ Index File downloaded")

    return nil
}

// fetchDependency downloads a dependency from a repo if not already cached
func fetchDependency(repo string, repoDir string, name string, version string, repoURL string) error {
    destPath := path.Join(helper.HelmCache, repoDir, fmt.Sprintf("%s-%s.tgz", name, version))
    if _, err := os.Stat(destPath); err == nil {
        log.Info().Msgf("✅ Dependency [%s-%s] already cached", name, version)
        return nil
    }

    log.Info().Msgf("🙅 Dependency [%s-%s] not cached", name, version)

    repoCacheDir := path.Join(helper.HelmCache, repoDir)
    // Create cache directory
    if err := os.MkdirAll(repoCacheDir, os.ModePerm); err != nil {
        return fmt.Errorf("❌ Failed to create cache directory: %s", err)
    }

    // Download dependency
    log.Info().Msgf("⏬ Downloading dependency [%s-%s] from [%s]", name, version, repo)
    if err := fluxhandler.HelmPull(repo, name, version, repoCacheDir, false); err != nil {
        return fmt.Errorf("❌ Failed to download or verify dependency: %s", err)
    }

    log.Info().Msg("✅ Dependency downloaded")

    return nil
}

// copyDependency copies a dependency from the cache to the chart folder
func copyDependency(chartFolder string, repo string, repoDir string, name string, version string) error {
    log.Info().Msg("📝 Copying dependency")

    targetChartsFolder := path.Join(chartFolder, "charts")
    if err := os.MkdirAll(targetChartsFolder, os.ModePerm); err != nil {
        return fmt.Errorf("❌ Failed to create charts directory: %s", err)
    }

    srcPath := path.Join(helper.HelmCache, repoDir, fmt.Sprintf("%s-%s.tgz", name, version))
    destPath := path.Join(targetChartsFolder, fmt.Sprintf("%s-%s.tgz", name, version))
    if err := helper.CopyFile(srcPath, destPath, false); err != nil {
        return fmt.Errorf("❌ Failed to copy dependency: %s", err)
    }

    log.Info().Msg("✅ Dependency copied!")
    return nil
}

func DownloadDeps(chartPath string, placeholder string) error {
    chartFolder := filepath.Dir(chartPath)

    helmChart := chartFile.NewHelmChart()
    err := helmChart.LoadFromFile(chartPath)
    if err != nil {
        log.Fatal().Err(err).Msgf("❌ Failed to load Helm chart from file in [%s]", chartFolder)
    }

    fmt.Print("\n\n")
    log.Info().Msgf("🏃 Processing Chart [%s] with [%d] dependencies", chartFolder, len(helmChart.Metadata.Dependencies))

    // Make sure the directory "charts" exists in the chart folder
    targetChartsFolder := path.Join(chartFolder, "charts")
    if err := os.MkdirAll(targetChartsFolder, os.ModePerm); err != nil {
        return fmt.Errorf("❌ Failed to create charts directory: %s", err)
    }

    // Process dependencies as needed
    for _, dep := range helmChart.Metadata.Dependencies {
        name := dep.Name
        version := dep.Version
        repo := dep.Repository
        repoURL := fmt.Sprintf("%s/index.yaml", strings.TrimRight(repo, "/"))

        fmt.Print("\n")
        log.Info().Msgf("📦 Dependency [%s]", name)
        log.Info().Msgf("🆚 Version [%s]", version)
        log.Info().Msgf("📥 Repo [%s]", repo)
        log.Info().Msgf("🔗 URL [%s]", repoURL)

        repoDir := repo
        // Remove protocol(s) from repoDir
        for _, prefix := range []string{"http://", "https://", "oci://"} {
            repoDir = strings.TrimPrefix(repoDir, prefix)
        }

        if err := fetchIndexFile(repo, repoDir, repoURL); err != nil {
            return fmt.Errorf("❌ Failed to fetch index file: %s", err)
        }

        if err := fetchDependency(repo, repoDir, name, version, repoURL); err != nil {
            log.Fatal().Err(err).Msg("❌ Failed to fetch dependency")
        }

        if err := copyDependency(chartFolder, repo, repoDir, name, version); err != nil {
            log.Fatal().Err(err).Msg("❌ Failed to copy dependency")
        }

        log.Info().Msg("✅ Dependency processed!")
    }

    log.Info().Msg("✅ Processing complete!")
    return nil
}
