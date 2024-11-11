package fluxhandler

import (
    "crypto/ecdsa"
    "crypto/elliptic"
    "crypto/rand"
    "crypto/x509"
    "encoding/pem"
    "fmt"
    "io/ioutil"
    "os"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"

    "github.com/truecharts/public/clustertool/pkg/helper"
    "golang.org/x/crypto/ssh"
    "gopkg.in/yaml.v3"
    corev1 "k8s.io/api/core/v1"
)

// Define a struct to map the YAML content
type Config struct {
    StringData map[string]string `yaml:"stringData"`
}

// CreateGitSecret generates a Kubernetes secret YAML file and a public key text file.
func CreateGitSecret(gitURL string) error {
    if gitURL == "" {
        gitURL = "github.com"
    }

    // Paths for files
    secretPath := filepath.Join(helper.ClusterPath, "kubernetes", "flux-system", "flux", "deploykey.secret.yaml")
    publicKeyPath := filepath.Join(".", "ssh-public-key.txt")

    // Check if secret YAML already exists
    if _, err := os.Stat(secretPath); os.IsNotExist(err) {
        // Generate ECDSA private key
        privateKey, err := ecdsa.GenerateKey(elliptic.P384(), rand.Reader)
        if err != nil {
            return fmt.Errorf("failed to generate ECDSA private key: %w", err)
        }

        // Encode private key to PEM format
        privateKeyPEMBlock, err := pemBlockForKey(privateKey)
        if err != nil {
            return fmt.Errorf("failed to create PEM block for private key: %w", err)
        }

        // Generate OpenSSH formatted public key
        publicKey, err := publicKeyToOpenSSH(&privateKey.PublicKey)
        if err != nil {
            return fmt.Errorf("failed to generate OpenSSH public key: %w", err)
        }

        // Write public key to file
        err = os.WriteFile(publicKeyPath, []byte(publicKey), 0644)
        if err != nil {
            return fmt.Errorf("failed to write public key to file: %w", err)
        }
        log.Info().Msgf("Public key saved to: %s\n", publicKeyPath)

        // Generate known_hosts entry
        knownHosts := getKnownHostsEntry(gitURL)

        // Generate Kubernetes secret YAML content
        secret := map[string]interface{}{
            "apiVersion": "v1",
            "kind":       "Secret",
            "metadata": map[string]interface{}{
                "name":      "deploy-key",
                "namespace": "flux-system",
            },
            "stringData": map[string]interface{}{
                "identity":     string(privateKeyPEMBlock),
                "identity.pub": publicKey,
                "known_hosts":  knownHosts,
            },
            "type": string(corev1.SecretTypeOpaque),
        }

        secretYAML, err := yaml.Marshal(secret)
        if err != nil {
            return fmt.Errorf("failed to marshal secret to YAML: %w", err)
        }

        // Write Kubernetes secret YAML to file
        err = os.MkdirAll(filepath.Dir(secretPath), 0755)
        if err != nil {
            return fmt.Errorf("failed to create directories: %w", err)
        }
        err = os.WriteFile(secretPath, secretYAML, 0644)
        if err != nil {
            return fmt.Errorf("failed to write secret YAML to file: %w", err)
        }
        log.Info().Msgf("Kubernetes secret YAML saved to: %s\n", secretPath)
    } else {
        // Secret YAML already exists, check if public key file exists
        if _, err := os.Stat(publicKeyPath); os.IsNotExist(err) {
            // Public key file does not exist, generate from existing secret
            secretYAML, err := os.ReadFile(secretPath)
            if err != nil {
                return fmt.Errorf("failed to read existing secret YAML: %w", err)
            }

            var secret corev1.Secret
            if err := yaml.Unmarshal(secretYAML, &secret); err != nil {
                return fmt.Errorf("failed to unmarshal secret YAML: %w", err)
            }

            if ppk, ok := secret.StringData["identity.pub"]; ok {
                err = os.WriteFile(publicKeyPath, []byte(ppk), 0644)
                if err != nil {
                    return fmt.Errorf("failed to write public key to file: %w", err)
                }
                log.Info().Msgf("Public key saved to: %s\n", publicKeyPath)
            } else {
                return fmt.Errorf("identity.pub not found in existing secret YAML")
            }
        } else {
            log.Info().Msgf("Public key file already exists: %s\n", publicKeyPath)
        }
    }

    return nil
}

// indentYaml indents each line of the YAML string with the specified indentation.
func indentYaml(yamlStr, indent string) string {
    lines := strings.Split(yamlStr, "\n")
    for i, line := range lines {
        if line != "" {
            lines[i] = indent + line
        }
    }
    return strings.Join(lines, "\n")
}

// ReplacePlaceholder replaces the placeholder in the file at the given path with the specified replacement string.
func ReplacePlaceholder(filePath, placeholder, replacement string) error {
    data, err := ioutil.ReadFile(filePath)
    if err != nil {
        return err
    }

    fileContent := string(data)
    fileContent = strings.Replace(fileContent, placeholder, replacement, -1)

    return ioutil.WriteFile(filePath, []byte(fileContent), 0644)
}

// pemBlockForKey creates a PEM block for the given private key
func pemBlockForKey(key *ecdsa.PrivateKey) ([]byte, error) {
    der, err := x509.MarshalECPrivateKey(key)
    if err != nil {
        return nil, fmt.Errorf("failed to marshal ECDSA private key: %w", err)
    }

    block := &pem.Block{
        Type:  "EC PRIVATE KEY",
        Bytes: der,
    }
    return pem.EncodeToMemory(block), nil
}

// publicKeyToOpenSSH converts an ECDSA public key to OpenSSH format
func publicKeyToOpenSSH(pub *ecdsa.PublicKey) (string, error) {
    pubKey, err := ssh.NewPublicKey(pub)
    if err != nil {
        return "", fmt.Errorf("failed to convert ECDSA public key to SSH format: %w", err)
    }
    return string(ssh.MarshalAuthorizedKey(pubKey)), nil
}

// getKnownHostsEntry generates the known_hosts entry for the given URL
func getKnownHostsEntry(url string) string {
    if strings.Contains(url, "github.com") {
        return getGithubKnownHostsEntry()
    }
    return generateKnownHostsEntry(url)
}

// getGithubKnownHostsEntry generates the known_hosts entry specifically for github.com
func getGithubKnownHostsEntry() string {
    return "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}

// generateKnownHostsEntry generates an SSH known_hosts entry for the given URL
func generateKnownHostsEntry(url string) string {
    return fmt.Sprintf("%s ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=", url)
}

// encodeToBase64 encodes data to a base64 string
func encodeToBase64(data []byte) string {
    return string(data)
}

// decodeBase64 decodes a base64 string
func decodeBase64(data string) ([]byte, error) {
    return []byte(data), nil
}
