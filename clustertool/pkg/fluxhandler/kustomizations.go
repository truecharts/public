package fluxhandler

import (
    "fmt"
    "io/ioutil"
    "os"
    "path/filepath"
    "strings"
)

// check if a file exists
func fileExists(filename string) bool {
    info, err := os.Stat(filename)
    if os.IsNotExist(err) {
        return false
    }
    return !info.IsDir()
}

// createKsYaml creates ks.yaml file with Flux Kustomization
func createKsYaml(path, parentFolder string) error {
    // Ensure the path uses forward slashes
    linuxPath := filepath.ToSlash(path)

    content := fmt.Sprintf(`apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: %s
  namespace: flux-system
spec:
  interval: 10m
  path: %s/app
  prune: true
  sourceRef:
    kind: GitRepository
    name: cluster

`, parentFolder, linuxPath)
    return ioutil.WriteFile(filepath.Join(path, "ks.yaml"), []byte(content), 0644)
}

// createOrUpdateKustomizationYaml creates or updates kustomization.yaml file
func createOrUpdateKustomizationYaml(path string) error {
    kustomizationPath := filepath.Join(path, "kustomization.yaml")
    var content string
    if fileExists(kustomizationPath) {
        // Read existing kustomization.yaml file
        data, err := ioutil.ReadFile(kustomizationPath)
        if err != nil {
            return err
        }
        content = string(data)
    } else {
        content = `apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
`
    }

    // List all files and folders in the current directory
    files, err := ioutil.ReadDir(path)
    if err != nil {
        return err
    }

    // Collect resources to add to kustomization.yaml
    var resources []string
    for _, file := range files {
        name := file.Name()
        // Ignore kustomization.yaml and ks.yaml files
        if name == "kustomization.yaml" || name == "ks.yaml" {
            continue
        }
        // Include only YAML files and directories
        if strings.HasSuffix(name, ".yaml") || file.IsDir() {
            if file.IsDir() && fileExists(filepath.Join(path, name, "ks.yaml")) {
                // Update folder entry to include ks.yaml
                name = fmt.Sprintf("%s/ks.yaml", name)
            }
            // Check if the file/folder is already listed
            if !strings.Contains(content, name) {
                if name == "namespace.yaml" {
                    resources = append([]string{name}, resources...)
                } else {
                    resources = append(resources, name)
                }
            }
        }
    }

    // Update kustomization.yaml content
    for _, resource := range resources {
        content += fmt.Sprintf("  - %s\n", resource)
    }

    contentLines := strings.Split(content, "\n")
    for _, item := range contentLines {

        if strings.HasSuffix(item, "/ks.yaml") {
            prefix := strings.TrimSuffix(item, "/ks.yaml")

            // Remove other resources with the same prefix from content
            var updatedContent []string
            for _, line := range contentLines {
                if line != prefix {
                    updatedContent = append(updatedContent, line)
                }
            }
            contentLines = updatedContent
        }
    }
    content = strings.Join(contentLines, "\n")

    // Write back the updated kustomization.yaml file
    return ioutil.WriteFile(kustomizationPath, []byte(content), 0644)
}

// processDirectory processes each directory recursively
func ProcessDirectory(path string) error {
    hasAppFolder := false
    hasKsYaml := false

    // Check for "app" folder and "ks.yaml" file
    files, err := ioutil.ReadDir(path)
    if err != nil {
        return err
    }
    for _, file := range files {
        if file.IsDir() && file.Name() == "app" {
            hasAppFolder = true
        }
        if file.Name() == "ks.yaml" {
            hasKsYaml = true
        }
    }

    // Create ks.yaml if "app" folder exists and ks.yaml does not exist
    if hasAppFolder && !hasKsYaml {
        parentFolder := filepath.Base(path)
        if err := createKsYaml(path, parentFolder); err != nil {
            return err
        }
    } else if !hasKsYaml { // Only create/update kustomization.yaml if ks.yaml does not exist
        // Create or update kustomization.yaml
        if err := createOrUpdateKustomizationYaml(path); err != nil {
            return err
        }
    }

    // Recurse into subdirectories
    for _, file := range files {
        if file.IsDir() {
            if err := ProcessDirectory(filepath.Join(path, file.Name())); err != nil {
                return err
            }
        }
    }

    return nil
}
