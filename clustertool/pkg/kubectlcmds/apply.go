package kubectlcmds

import (
	"bytes"
	"context"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"regexp"

	"github.com/go-logr/logr"
	"github.com/go-logr/zapr"
	"github.com/truecharts/private/clustertool/pkg/helper"
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
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
	// Load kubeconfig from the default location
	kubeconfig := filepath.Join(homedir.HomeDir(), ".kube", "config")
	config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		return nil, fmt.Errorf("failed to load kubeconfig: %v", err)
	}

	// Create a controller-runtime client
	c, err := client.New(config, client.Options{})
	if err != nil {
		return nil, fmt.Errorf("failed to create Kubernetes client: %v", err)
	}

	return c, nil
}

// setupLogger initializes a logger that writes to a buffer and returns both
func setupLogger() (logr.Logger, *bytes.Buffer, error) {
	// Create a buffer to capture logs
	var buf bytes.Buffer

	// Create a WriteSyncer to write to the buffer
	writeSyncer := zapcore.AddSync(&buf)

	// Configure zap to use console encoder for readability
	encoderCfg := zap.NewProductionEncoderConfig()
	encoderCfg.EncodeTime = zapcore.ISO8601TimeEncoder
	encoder := zapcore.NewConsoleEncoder(encoderCfg)

	// Set log level to Info
	level := zapcore.InfoLevel

	// Create zap core
	core := zapcore.NewCore(encoder, writeSyncer, level)

	// Create zap logger
	zapLogger := zap.New(core)

	// Wrap zap logger with zapr to get a logr.Logger interface
	log := zapr.NewLogger(zapLogger)

	return log, &buf, nil
}

// applyYAML applies the given YAML data to the Kubernetes cluster using the provided client and logger
func applyYAML(k8sClient client.Client, yamlData []byte, log logr.Logger) error {
	// Parse the YAML into KIO nodes
	reader := kio.ByteReader{
		Reader: bytes.NewReader(yamlData),
	}
	nodes, err := reader.Read()
	if err != nil {
		return fmt.Errorf("failed to parse YAML: %v", err)
	}

	// Apply each node to the cluster
	for _, node := range nodes {
		obj := &unstructured.Unstructured{}
		if err := yaml.Unmarshal([]byte(node.MustString()), obj); err != nil {
			return fmt.Errorf("failed to unmarshal node: %v", err)
		}
		if err := k8sClient.Patch(context.TODO(), obj, client.Apply, client.FieldOwner("kustomize-controller")); err != nil {
			return fmt.Errorf("failed to apply object: %v", err)
		}
		log.Info("Successfully applied object", "object", obj.GetName(), "kind", obj.GetKind(), "namespace", obj.GetNamespace())
	}

	return nil
}

// filterLogOutput filters the log data by removing strings that match any of the provided regex patterns
func filterLogOutput(logData string) (string, error) {
	filteredLog := logData
	for _, pattern := range helper.KubeFilterStr {
		re, err := regexp.Compile(pattern)
		if err != nil {
			return "", fmt.Errorf("invalid regex pattern '%s': %v", pattern, err)
		}
		filteredLog = re.ReplaceAllString(filteredLog, "")
	}
	return filteredLog, nil
}

// KubectlApply applies a YAML file to the Kubernetes cluster and filters the logs
func KubectlApply(ctx context.Context, filePath string) error {
	// Check if the file exists
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		return fmt.Errorf("file does not exist: %s", filePath)
	}

	// Read the YAML file
	yamlData, err := ioutil.ReadFile(filePath)
	if err != nil {
		return fmt.Errorf("failed to read YAML file: %v", err)
	}

	// Initialize logger and buffer
	log, buf, err := setupLogger()
	if err != nil {
		return fmt.Errorf("failed to set up logger: %v", err)
	}

	// Initialize Kubernetes client
	k8sClient, err := getKubeClient()
	if err != nil {
		return err
	}

	// Apply the YAML to the cluster
	if err := applyYAML(k8sClient, yamlData, log); err != nil {
		return fmt.Errorf("failed to apply YAML: %v", err)
	}

	// Get log output from buffer
	logOutput := buf.String()

	// Filter the logs
	filteredLog, err := filterLogOutput(logOutput)
	if err != nil {
		return fmt.Errorf("failed to filter logs: %v", err)
	}

	// Output filtered logs
	fmt.Println(filteredLog)

	return nil
}

// KubectlApplyKustomize applies a kustomize directory or file to the Kubernetes cluster and filters the logs
func KubectlApplyKustomize(ctx context.Context, filePath string) error {
	// Check if the path exists
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		return fmt.Errorf("path does not exist: %s", filePath)
	}

	// Determine if the path is a directory or a file
	fileInfo, err := os.Stat(filePath)
	if err != nil {
		return fmt.Errorf("failed to stat path: %v", err)
	}

	var kustomizePath string
	if fileInfo.IsDir() {
		// If it's a directory, use it as the kustomize path
		kustomizePath = filePath
	} else {
		// If it's a file, use its directory as the kustomize path
		kustomizePath = filepath.Dir(filePath)
	}

	// Process kustomize to get the YAML output
	fSys := filesys.MakeFsOnDisk()
	k := krusty.MakeKustomizer(krusty.MakeDefaultOptions())
	resMap, err := k.Run(fSys, kustomizePath)
	if err != nil {
		return fmt.Errorf("failed to run kustomize: %v", err)
	}

	// Convert ResMap to YAML
	output, err := resMap.AsYaml()
	if err != nil {
		return fmt.Errorf("failed to convert ResMap to YAML: %v", err)
	}

	// Initialize logger and buffer
	log, buf, err := setupLogger()
	if err != nil {
		return fmt.Errorf("failed to set up logger: %v", err)
	}

	// Initialize Kubernetes client
	k8sClient, err := getKubeClient()
	if err != nil {
		return err
	}

	// Apply the YAML to the cluster
	if err := applyYAML(k8sClient, output, log); err != nil {
		return fmt.Errorf("failed to apply YAML: %v", err)
	}

	// Get log output from buffer
	logOutput := buf.String()

	// Filter the logs
	filteredLog, err := filterLogOutput(logOutput)
	if err != nil {
		return fmt.Errorf("failed to filter logs: %v", err)
	}

	// Output filtered logs
	fmt.Println(filteredLog)

	return nil
}
