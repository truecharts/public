package kubectlcmds

import (
    "bytes"
    "context"
    "fmt"
    "io/ioutil"
    "os"
    "path/filepath"
    "time"

    "github.com/rs/zerolog/log"
    "k8s.io/apimachinery/pkg/apis/meta/v1/unstructured"
    "k8s.io/client-go/tools/clientcmd"
    "k8s.io/client-go/util/homedir"
    "sigs.k8s.io/controller-runtime/pkg/client"
    "sigs.k8s.io/kustomize/api/krusty"
    "sigs.k8s.io/kustomize/kyaml/filesys"
    "sigs.k8s.io/kustomize/kyaml/kio"
    "sigs.k8s.io/yaml"
)

// getKubeClient initializes and returns a controller-runtime client.Client
func getKubeClient() (client.Client, error) {
    log.Trace().Msg("Initializing Kubernetes client")

    // Load kubeconfig from the default location
    kubeconfig := filepath.Join(homedir.HomeDir(), ".kube", "config")
    config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
    if err != nil {
        log.Error().Err(err).Msg("Failed to load kubeconfig")
        return nil, fmt.Errorf("failed to load kubeconfig: %v", err)
    }

    // Create a controller-runtime client
    c, err := client.New(config, client.Options{})
    if err != nil {
        log.Error().Err(err).Msg("Failed to create Kubernetes client")
        return nil, fmt.Errorf("failed to create Kubernetes client: %v", err)
    }

    log.Debug().Msg("Successfully initialized Kubernetes client")
    return c, nil
}

// applyYAML applies the given YAML data to the Kubernetes cluster using the provided client
func applyYAML(k8sClient client.Client, yamlData []byte) error {
    log.Trace().Msg("Applying YAML data to the Kubernetes cluster")

    // Parse the YAML into KIO nodes
    reader := kio.ByteReader{
        Reader: bytes.NewReader(yamlData),
    }
    nodes, err := reader.Read()
    if err != nil {
        log.Error().Err(err).Msg("Failed to parse YAML")
        return fmt.Errorf("failed to parse YAML: %v", err)
    }

    // Apply each node to the cluster
    for _, node := range nodes {
        obj := &unstructured.Unstructured{}
        if err := yaml.Unmarshal([]byte(node.MustString()), obj); err != nil {
            log.Error().Err(err).Msg("Failed to unmarshal node")
            return fmt.Errorf("failed to unmarshal node: %v", err)
        }
        if err := k8sClient.Patch(context.TODO(), obj, client.Apply, client.FieldOwner("kustomize-controller")); err != nil {
            log.Warn().Err(err).Msg("Failed to apply yaml object... trying again in 15 seconds...")
            time.Sleep(15 * time.Second)
            if err := k8sClient.Patch(context.TODO(), obj, client.Apply, client.FieldOwner("kustomize-controller")); err != nil {
                log.Error().Err(err).Msg("Failed to apply object")
                return fmt.Errorf("failed to apply object: %v", err)
            }
        }
        log.Info().Msgf("Successfully applied object: %s of kind: %s in namespace: %s", obj.GetName(), obj.GetKind(), obj.GetNamespace())
    }

    log.Debug().Msg("YAML application completed")
    return nil
}

// KubectlApply applies a YAML file to the Kubernetes cluster and filters the logs
func KubectlApply(ctx context.Context, filePath string) error {
    log.Trace().Msgf("Applying YAML file at path: %s", filePath)

    // Check if the file exists
    if _, err := os.Stat(filePath); os.IsNotExist(err) {
        log.Error().Err(err).Msgf("File does not exist: %s", filePath)
        return fmt.Errorf("file does not exist: %s", filePath)
    }

    // Read the YAML file
    yamlData, err := ioutil.ReadFile(filePath)
    if err != nil {
        log.Error().Err(err).Msg("Failed to read YAML file")
        return fmt.Errorf("failed to read YAML file: %v", err)
    }

    // Initialize Kubernetes client
    k8sClient, err := getKubeClient()
    if err != nil {
        log.Error().Err(err).Msg("Failed to initialize Kubernetes client")
        return err
    }

    // Apply the YAML to the cluster
    if err := applyYAML(k8sClient, yamlData); err != nil {
        log.Error().Err(err).Msg("Failed to apply YAML")
        return fmt.Errorf("failed to apply YAML: %v", err)
    }

    // Filter the logs
    log.Info().Msg("KubectlApply operation completed")

    return nil
}

// KubectlApplyKustomize applies a kustomize directory or file to the Kubernetes cluster and filters the logs
func KubectlApplyKustomize(ctx context.Context, filePath string) error {
    log.Trace().Msgf("Applying Kustomize directory or file at path: %s", filePath)

    // Check if the path exists
    if _, err := os.Stat(filePath); os.IsNotExist(err) {
        log.Error().Err(err).Msgf("Path does not exist: %s", filePath)
        return fmt.Errorf("path does not exist: %s", filePath)
    }

    // Determine if the path is a directory or a file
    fileInfo, err := os.Stat(filePath)
    if err != nil {
        log.Error().Err(err).Msg("Failed to stat path")
        return fmt.Errorf("failed to stat path: %v", err)
    }

    var kustomizePath string
    if fileInfo.IsDir() {
        // If it's a directory, use it as the kustomize path
        kustomizePath = filePath
        log.Debug().Msgf("Using directory as kustomize path: %s", kustomizePath)
    } else {
        // If it's a file, use its directory as the kustomize path
        kustomizePath = filepath.Dir(filePath)
        log.Debug().Msgf("Using file's directory as kustomize path: %s", kustomizePath)
    }

    // Process kustomize to get the YAML output
    fSys := filesys.MakeFsOnDisk()
    k := krusty.MakeKustomizer(krusty.MakeDefaultOptions())
    resMap, err := k.Run(fSys, kustomizePath)
    if err != nil {
        log.Error().Err(err).Msg("Failed to run kustomize")
        return fmt.Errorf("failed to run kustomize: %v", err)
    }

    // Get the YAML output from the resMap
    yamlData, err := resMap.AsYaml()
    if err != nil {
        log.Error().Err(err).Msg("Failed to convert kustomize output to YAML")
        return fmt.Errorf("failed to convert kustomize output to YAML: %v", err)
    }

    // Initialize Kubernetes client
    k8sClient, err := getKubeClient()
    if err != nil {
        log.Error().Err(err).Msg("Failed to initialize Kubernetes client")
        return err
    }

    // Apply the YAML to the cluster
    if err := applyYAML(k8sClient, yamlData); err != nil {
        log.Error().Err(err).Msg("Failed to apply YAML from kustomize")
        return fmt.Errorf("failed to apply YAML from kustomize: %v", err)
    }

    log.Info().Msg("KubectlApplyKustomize operation completed")

    return nil
}
