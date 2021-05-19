package helmunit

import (
    "io"

    "helm.sh/helm/v3/pkg/action"
    "helm.sh/helm/v3/pkg/chart/loader"
    "helm.sh/helm/v3/pkg/cli"
    v "helm.sh/helm/v3/pkg/cli/values"
    "helm.sh/helm/v3/pkg/downloader"
    "helm.sh/helm/v3/pkg/getter"
    "helm.sh/helm/v3/pkg/releaseutil"
    "sigs.k8s.io/yaml"
)

var settings *cli.EnvSettings

type HelmChart struct {
    Name      string
    ChartPath string
    Manifests manifestCollection
    Hooks     manifestCollection
    Notes     string
    Values    map[string]interface{}
}

func New(name string, chartPath string) HelmChart {
    h := HelmChart{
        Name:      name,
        ChartPath: chartPath,
        Manifests: make(manifestCollection),
        Hooks:     make(manifestCollection),
    }
    return h
}

func (c *HelmChart) UpdateDependencies() error {
    settings = cli.New()
    client := defaultClient(c.Name, settings.Namespace())
    p := getter.All(&cli.EnvSettings{})

    // Check chart dependencies to make sure all are present in /charts
    chartRequested, err := loader.Load(c.ChartPath)
    if err != nil {
        return err
    }

    if req := chartRequested.Metadata.Dependencies; req != nil {
        if err := action.CheckDependencies(chartRequested, req); err != nil {
            if client.DependencyUpdate {
                man := &downloader.Manager{
                    Out:        io.Discard,
                    ChartPath:  c.ChartPath,
                    Keyring:    client.ChartPathOptions.Keyring,
                    SkipUpdate: false,
                    Getters:    p,
                }
                if err := man.Update(); err != nil {
                    return err
                }
            }
        }
    }
    return nil
}

func (c *HelmChart) Render(valueFilePaths, stringValues []string, rawYamlValues *string) error {
    settings = cli.New()
    client := defaultClient(c.Name, settings.Namespace())
    c.Manifests.Initialize()
    c.Hooks.Initialize()

    p := getter.All(&cli.EnvSettings{})
    valueOpts := &v.Options{
        ValueFiles: valueFilePaths,
        Values:     stringValues,
    }

    values, err := valueOpts.MergeValues(p)
    if err != nil {
        return err
    }

    if !(rawYamlValues == nil) {
        currentMap := map[string]interface{}{}
        if err := yaml.Unmarshal([]byte(*rawYamlValues), &currentMap); err != nil {
            panic(err)
        }
        values = mergeMaps(currentMap, values)
    }

    c.Values = values

    chartRequested, err := loader.Load(c.ChartPath)
    if err != nil {
        return err
    }

    release, err := client.Run(chartRequested, values)
    if err != nil {
        return err
    }

    for _, manifest := range releaseutil.SplitManifests(release.Manifest) {
        err := c.Manifests.Add([]byte(manifest))
        if err != nil {
            return err
        }
    }

    for _, manifest := range release.Hooks {
        err := c.Hooks.Add([]byte(manifest.Manifest))
        if err != nil {
            return err
        }
    }

    c.Notes = release.Info.Notes

    return nil
}

func defaultClient(name, namespace string) *action.Install {
    client := action.NewInstall(&action.Configuration{})
    client.Version = ">0.0.0-0"
    client.ReleaseName = name
    client.Namespace = namespace
    client.ClientOnly = true
    client.DryRun = true
    client.DependencyUpdate = true

    return client
}
