package fluxhandler

import (
    "context"
    "fmt"
    "io/ioutil"
    "os"
    "path"
    "path/filepath"
    "strings"
    "time"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "helm.sh/helm/v3/pkg/action"
    "helm.sh/helm/v3/pkg/chart/loader"
    "helm.sh/helm/v3/pkg/cli"
    "helm.sh/helm/v3/pkg/cli/values"
    "helm.sh/helm/v3/pkg/getter"
    "helm.sh/helm/v3/pkg/registry"
    "helm.sh/helm/v3/pkg/release"
    "helm.sh/helm/v3/pkg/repo"
    corev1 "k8s.io/api/core/v1"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    "sigs.k8s.io/kustomize/kyaml/yaml"
)

func newDefaultRegistryClient(plainHTTP bool, settings *cli.EnvSettings) (*registry.Client, error) {
    opts := []registry.ClientOption{
        registry.ClientOptDebug(settings.Debug),
        registry.ClientOptEnableCache(true),
        registry.ClientOptWriter(os.Stdout),
        registry.ClientOptCredentialsFile(settings.RegistryConfig),
    }
    if plainHTTP {
        opts = append(opts, registry.ClientOptPlainHTTP())
    }

    // Create a new registry client
    registryClient, err := registry.NewClient(opts...)
    if err != nil {
        return nil, err
    }
    return registryClient, nil
}

// HelmPull downloads a Helm chart from a repository
func HelmPull(repo string, name string, version string, dest string, silent bool) error {
    settings := cli.New()
    actionConfig := new(action.Configuration)

    // Define logger based on the silent parameter
    var logger func(string, ...interface{})
    if silent {
        logger = noOpLog
    } else {
        logger = log.Printf
    }

    // Initialize actionConfig with the appropriate logger
    if err := actionConfig.Init(settings.RESTClientGetter(), "", os.Getenv("HELM_DRIVER"), logger); err != nil {
        return fmt.Errorf("failed to initialize Helm action config: %w", err)
    }

    registryClient, err := newDefaultRegistryClient(false, settings)
    if err != nil {
        return err
    }
    actionConfig.RegistryClient = registryClient

    client := action.NewPullWithOpts(action.WithConfig(actionConfig))
    client.Settings = settings
    client.RepoURL = repo
    client.Version = version
    client.DestDir = filepath.Join(helper.HelmCache, dest)

    // Create cache directory
    if err := os.MkdirAll(client.DestDir, os.ModePerm); err != nil {
        return fmt.Errorf("❌ Failed to create cache directory: %s", err)
    }

    switch repo {
    case "https://charts.truecharts.org",
        "https://library-charts.truecharts.org",
        "https://deps.truecharts.org":
        client.Keyring = helper.GpgDir + "/pubring.gpg"
        client.Verify = true
    case "https://charts.jetstack.io":
        client.Keyring = helper.GpgDir + "/certman.gpg"
        client.Verify = true
    default:
        // Do nothing for other repositories
    }

    link := ""
    if strings.HasPrefix(repo, "http") {
        link = name
        repoName := cleanRepoURL(repo)
        updateHelmRepo(repoName, repo, silent)
        repo = repoName
    } else {
        link = repo + "/" + name
        client.RepoURL = ""
    }

    output, err := client.Run(link)

    if err != nil {
        os.Remove(path.Join(dest, fmt.Sprintf("%s-%s.tgz", name, version)))
        return err
    }
    if !silent {
        log.Info().Msg("✅ Dependency Downloaded!")
    }
    if client.Keyring != "" && client.Keyring != "nil" {
        if !silent {
            log.Info().Msg("✅ Dependency Verified")
        }
    }

    if output != "" {
        log.Info().Msgf("☸ Helm output: %s", output)
    }
    return nil
}

func noOpLog(format string, v ...interface{}) {}

// HelmInstall installs a Helm chart with provided parameters
func HelmInstall(repoURL string, chartName string, releaseName string, namespace string, valuesFile string, version string, dryRun bool, wait bool, silent bool) error {
    if dryRun {
        log.Info().Msg("dryRun not possible...")
        return nil
    }

    settings := cli.New()
    actionConfig := new(action.Configuration)

    settings.SetNamespace(namespace)

    var logger func(string, ...interface{})
    if silent {
        logger = noOpLog

    } else {
        logger = log.Printf
    }

    if err := actionConfig.Init(settings.RESTClientGetter(), namespace,
        os.Getenv("HELM_DRIVER"), logger); err != nil {
        return fmt.Errorf("failed to initialize Helm action config: %w", err)
    }

    // Ensure namespace exists or create it
    if err := ensureNamespace(actionConfig, namespace); err != nil {
        return fmt.Errorf("failed to ensure namespace exists: %w", err)
    }

    var chartPath string
    var err error

    // Determine chart path based on chartName format
    if strings.HasPrefix(repoURL, "http://") || strings.HasPrefix(repoURL, "https://") || strings.HasPrefix(repoURL, "oci://") {
        // Handle HTTP or OCI URL
        err = HelmPull(repoURL, chartName, version, "", true)
        if err != nil {
            return fmt.Errorf("failed to pull chart %s: %w", chartName, err)
        }
        chartPath = path.Join(helper.HelmCache, fmt.Sprintf("%s-%s.tgz", chartName, version))

    } else {
        // Local chart path
        chartPath = repoURL
    }

    // Load the Helm chart using loader.Load
    chart, err := loader.Load(chartPath)
    if err != nil {
        return fmt.Errorf("failed to load chart: %w", err)
    }

    // Set up Helm install action
    client := action.NewInstall(actionConfig)
    client.Namespace = namespace
    client.ReleaseName = releaseName
    client.DryRun = dryRun
    client.Version = version

    tempValuesName := releaseName + "tempvalues.yaml"
    tempValuesPath := path.Join(helper.HelmCache, tempValuesName)
    // Create values.yaml from chart.Values
    err = createValuesYAML(chart.Values, tempValuesPath)
    if err != nil {
        return fmt.Errorf("error creating tempvalues.yaml: %w", err)
    }
    valueFiles := []string{tempValuesPath}

    // Get the directory part of the path
    directory := filepath.Dir(valuesFile)

    helmreleasePath := path.Join(directory, "helm-release.yaml")

    helmRelease, err := LoadHelmRelease(helmreleasePath)
    if err != nil {

    }
    tempHRValuesName := releaseName + "temphrvalues.yaml"
    tempHRValuesPath := path.Join(helper.HelmCache, tempHRValuesName)
    err = createValuesYAML(helmRelease.Spec.Values, tempHRValuesPath)
    if err != nil {
        return fmt.Errorf("error creating temphrvalues.yaml: %w", err)
    }
    helper.EnvSubst(tempHRValuesPath, helper.TalEnv)
    valueFiles = append(valueFiles, tempHRValuesPath)

    if _, err := os.Stat(valuesFile); err == nil {
        valueFiles = append(valueFiles, valuesFile)

    }

    overrideValuesPath := path.Join(directory, "bootstrap-values.yaml.ct")

    if _, err := os.Stat(overrideValuesPath); err == nil {
        valueFiles = append(valueFiles, overrideValuesPath)
    }

    // Prepare values for installation
    valOpts := &values.Options{
        ValueFiles: valueFiles, // Specify value file to merge
    }

    // Create getter to fetch values from file
    valProviders := getter.All(settings)

    // Merge values with chart's default values
    vals, err := valOpts.MergeValues(valProviders)
    if err != nil {
        return fmt.Errorf("failed to merge values: %w", err)
    }

    // Install the chart with merged values
    log.Debug().Msg("Installing chart...")
    release, err := client.Run(chart, vals)
    if err != nil {
        log.Debug().Msg("Chart install returned an error")
        if strings.Contains(err.Error(), "timed out") {
            // Wait for 15 seconds and try again
            log.Warn().Msg("Chart install recieved a timeout, retrying in 15 seconds...")
            time.Sleep(15 * time.Second)
            release, err = client.Run(chart, vals)
            if err != nil && strings.Contains(err.Error(), "timed out") {
                return fmt.Errorf("failed to install chart after retry, with another timeout: %w", err)
            } else if err != nil {
                return fmt.Errorf("failed to install chart after retry: %w", err)
            }
        } else {
            return fmt.Errorf("failed to install chart: %w", err)
        }
    }

    if wait {
        waitForRelease(actionConfig, release.Name, client.Namespace)
    }

    log.Printf("Installed Chart: %s in namespace: %s\n", release.Name, release.Namespace)
    log.Printf("Installed Chart values: %v\n", release.Config)

    return nil
}

func ensureNamespace(actionConfig *action.Configuration, namespace string) error {
    // Check if the namespace exists
    exists, err := namespaceExists(actionConfig, namespace)
    if err != nil {
        return fmt.Errorf("failed to check if namespace exists: %w", err)
    }

    if !exists {
        // Create the namespace if it does not exist
        err := createNamespace(actionConfig, namespace)
        if err != nil {
            return fmt.Errorf("failed to create namespace: %w", err)
        }
    }

    return nil
}

// HelmUpgrade upgrades a Helm release with provided parameters
// HelmUpgrade upgrades a Helm release with provided parameters
func HelmUpgrade(repoURL string, chartName string, releaseName string, namespace string, valuesFile string, version string, wait bool, silent bool) error {
    settings := cli.New()
    actionConfig := new(action.Configuration)

    settings.SetNamespace(namespace)

    var logger func(string, ...interface{})
    if silent {
        logger = noOpLog
    } else {
        logger = log.Printf
    }

    if err := actionConfig.Init(settings.RESTClientGetter(), namespace,
        os.Getenv("HELM_DRIVER"), logger); err != nil {
        return fmt.Errorf("failed to initialize Helm action config: %w", err)
    }

    // Ensure namespace exists or create it
    if err := ensureNamespace(actionConfig, namespace); err != nil {
        return fmt.Errorf("failed to ensure namespace exists: %w", err)
    }

    var chartPath string
    var err error

    // Determine chart path based on chartName format
    if strings.HasPrefix(repoURL, "http://") || strings.HasPrefix(repoURL, "https://") || strings.HasPrefix(repoURL, "oci://") {
        // Handle HTTP or OCI URL
        err = HelmPull(repoURL, chartName, version, "", true)
        if err != nil {
            return fmt.Errorf("failed to pull chart %s: %w", chartName, err)
        }
        chartPath = path.Join(helper.HelmCache, fmt.Sprintf("%s-%s.tgz", chartName, version))

    } else {
        // Local chart path
        chartPath = repoURL
    }

    // Load the Helm chart using loader.Load
    chart, err := loader.Load(chartPath)
    if err != nil {
        return fmt.Errorf("failed to load chart: %w", err)
    }

    // Set up Helm upgrade action
    client := action.NewUpgrade(actionConfig)
    client.Namespace = namespace
    client.Version = version

    tempValuesName := releaseName + "tempvalues.yaml"
    tempValuesPath := path.Join(helper.HelmCache, tempValuesName)
    err = createValuesYAML(chart.Values, tempValuesPath)
    if err != nil {
        return fmt.Errorf("error creating tempvalues.yaml: %w", err)
    }
    valueFiles := []string{tempValuesPath}

    // Get the directory part of the path
    directory := filepath.Dir(valuesFile)

    helmreleasePath := path.Join(directory, "helm-release.yaml")

    helmRelease, err := LoadHelmRelease(helmreleasePath)
    if err != nil {
        return fmt.Errorf("error loading helm-release.yaml: %w", err)
    }

    tempHRValuesName := releaseName + "temphrvalues.yaml"
    tempHRValuesPath := path.Join(helper.HelmCache, tempHRValuesName)
    err = createValuesYAML(helmRelease.Spec.Values, tempHRValuesPath)
    if err != nil {
        return fmt.Errorf("error creating temphrvalues.yaml: %w", err)
    }
    helper.EnvSubst(tempHRValuesPath, helper.TalEnv)
    valueFiles = append(valueFiles, tempHRValuesPath)

    if _, err := os.Stat(valuesFile); err == nil {
        valueFiles = append(valueFiles, valuesFile)
    }

    overrideValuesPath := path.Join(directory, "bootstrap-values.yaml.ct")

    if _, err := os.Stat(overrideValuesPath); err == nil {
        valueFiles = append(valueFiles, overrideValuesPath)
    }

    // Prepare values for upgrade
    valOpts := &values.Options{
        ValueFiles: valueFiles, // Specify value file to merge
    }

    // Create getter to fetch values from file
    valProviders := getter.All(settings)

    // Merge values with chart's default values
    vals, err := valOpts.MergeValues(valProviders)
    if err != nil {
        return fmt.Errorf("failed to merge values: %w", err)
    }

    // Perform the upgrade with merged values
    release, err := client.Run(releaseName, chart, vals)
    if err != nil {
        return fmt.Errorf("failed to upgrade chart: %w", err)
    }

    if wait {
        waitForRelease(actionConfig, release.Name, client.Namespace)
    }

    log.Printf("Upgraded Chart: %s in namespace: %s\n", release.Name, release.Namespace)
    log.Printf("Upgraded Chart values: %v\n", release.Config)

    return nil
}

func namespaceExists(actionConfig *action.Configuration, namespace string) (bool, error) {
    // Retrieve Kubernetes client set from actionConfig
    clientset, err := actionConfig.KubernetesClientSet()
    if err != nil {
        return false, fmt.Errorf("failed to get Kubernetes client set: %w", err)
    }

    // Use clientset to check if the namespace exists
    _, err = clientset.CoreV1().Namespaces().Get(context.Background(), namespace, metav1.GetOptions{})
    if err != nil {
        return false, nil // Namespace doesn't exist or other error occurred
    }
    return true, nil // Namespace exists
}

func createNamespace(actionConfig *action.Configuration, namespace string) error {
    // Retrieve Kubernetes client set from actionConfig
    clientset, err := actionConfig.KubernetesClientSet()
    if err != nil {
        return fmt.Errorf("failed to get Kubernetes client set: %w", err)
    }

    // Create the namespace using clientset
    _, err = clientset.CoreV1().Namespaces().Create(context.Background(), &corev1.Namespace{
        ObjectMeta: metav1.ObjectMeta{
            Name: namespace,
        },
    }, metav1.CreateOptions{})
    if err != nil {
        if strings.Contains(err.Error(), "already exists") {

        } else {
            return fmt.Errorf("failed to create namespace: %w", err)
        }
    }
    return nil
}

func createValuesYAML(values map[string]interface{}, fileName string) error {
    removeFileIfExists(fileName)
    // Marshal values map into YAML format
    data, err := yaml.Marshal(values)
    if err != nil {
        return err
    }

    // Write YAML data into the file
    err = ioutil.WriteFile(fileName, data, 0644)
    if err != nil {
        return err
    }

    return nil
}

func removeFileIfExists(fileName string) error {
    // Check if the file exists
    _, err := os.Stat(fileName)
    if err == nil {
        // Delete the file
        err = os.Remove(fileName)
        if err != nil {
            return err
        }
    } else if !os.IsNotExist(err) {
        // Return other errors if the file check failed for a reason other than not existing
        return err
    }

    return nil
}

func updateHelmRepo(name string, url string, silent bool) error {
    // Create a Helm repository configuration
    repoConfig := &repo.Entry{
        Name: name,
        URL:  url,
    }

    // Initialize Helm settings
    settings := cli.New()

    // Create a repository object
    r, err := repo.NewChartRepository(repoConfig, getter.All(settings))
    if err != nil {
        return fmt.Errorf("failed to create chart repository: %w", err)
    }

    // Ensure the repository cache directory exists
    cacheDir := settings.RepositoryCache
    if err := os.MkdirAll(cacheDir, os.ModePerm); err != nil {
        return fmt.Errorf("failed to create cache directory: %w", err)
    }

    // Download the latest index file
    if _, err := r.DownloadIndexFile(); err != nil {
        return fmt.Errorf("failed to download index file: %w", err)
    }

    // Load existing repositories file or create a new one
    repoFile := settings.RepositoryConfig
    repoFileContent := repo.NewFile()
    if _, err := os.Stat(repoFile); err == nil {
        repoFileContent, err = repo.LoadFile(repoFile)
        if err != nil {
            return fmt.Errorf("failed to load repositories file: %w", err)
        }
    }

    // Update the repositories file with the new repository
    if !repoFileContent.Has(name) {
        repoFileContent.Update(repoConfig)
    }

    if err := repoFileContent.WriteFile(repoFile, 0644); err != nil {
        return fmt.Errorf("failed to write repositories file: %w", err)
    }

    if !silent {
        log.Info().Msgf("Successfully updated repository '%s' from %s\n", name, url)
    }
    return nil
}

// cleanRepoURL performs the specified operations on the input URL
func cleanRepoURL(url string) string {
    // Remove http:// or https:// prefix
    url = strings.TrimPrefix(url, "http://")
    url = strings.TrimPrefix(url, "https://")

    // Remove charts. prefix if present
    url = strings.TrimPrefix(url, "charts.")

    // Remove helm. prefix if present
    url = strings.TrimPrefix(url, "helm.")

    // Remove everything after the last dot
    lastDotIndex := strings.LastIndex(url, ".")
    if lastDotIndex != -1 {
        url = url[:lastDotIndex]
    }

    url = repoURL(url)

    return url
}

func repoURL(url string) string {
    parts := strings.SplitN(url, "/", 2) // Split into two parts at the first "/"
    if len(parts) > 0 {
        url = parts[0]
    }

    return url
}

func waitForRelease(actionConfig *action.Configuration, releaseName, namespace string) {
    statusClient := action.NewStatus(actionConfig)
    for {
        rel, err := statusClient.Run(releaseName)
        if err != nil {
            log.Info().Msgf("failed to get release status: %v", err)
        }
        if rel.Info.Status == release.StatusDeployed {
            log.Info().Msgf("Release %s is now deployed\n", releaseName)
            break
        }
        log.Info().Msgf("Waiting for release %s to be deployed (current status: %s)\n", releaseName, rel.Info.Status)
        time.Sleep(5 * time.Second)
    }
}
