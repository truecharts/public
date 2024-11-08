package helper

import (
    "bytes"
    "errors"
    "fmt"
    "io/ioutil"
    "log/slog"
    "os"
    "path/filepath"
    "regexp"

    "github.com/joho/godotenv"
    "github.com/rs/zerolog/log"
)

// LoadEnvFromFile reads yaml data from the "output.yaml" file and sets
// environment variables in the global output map. It skips if the file
// doesn't exist. It returns an error, if any.
func LoadEnvFromFile(file string, output map[string]string) error {
    if _, err := os.Stat(file); err == nil {
        slog.Debug(fmt.Sprintf("loading environment variables from %s", file))
        content, err := os.ReadFile(file)
        if err != nil {
            return fmt.Errorf("reading file %s: %s", file, err)
        }

        // Strip comments from YAML content before processing
        content = StripYamlComment(content)

        content = StripYAMLDocDelimiter(content)
        if err := LoadEnv(content, output); err != nil {
            return fmt.Errorf("trying to load env from %s: %s", file, err)
        }
    } else if errors.Is(err, os.ErrNotExist) {
        return fmt.Errorf("file %s does not exist", file)
    } else {
        return fmt.Errorf("trying to stat %s: %s", file, err)
    }
    return nil
}

// LoadEnv reads yaml data and sets environment variables in the global output map.
// It returns an error, if any.
func LoadEnv(file []byte, output map[string]string) error {
    mFile, err := godotenv.Unmarshal(string(file))
    if err != nil {
        return err
    }

    for k, v := range mFile {
        slog.Debug(fmt.Sprintf("loaded environment variable: %s=%s", k, v))
        output[k] = v
    }
    return nil
}

// stripYamlComment takes yaml bytes and returns them back with
// comments stripped.
func StripYamlComment(file []byte) []byte {
    // FIXME use better logic than regex.
    re := regexp.MustCompile(".?#.*\n")
    stripped := re.ReplaceAllFunc(file, func(b []byte) []byte {
        re := regexp.MustCompile("^['\"].+['\"]|^[a-zA-Z0-9]")
        if re.Match(b) {
            return b
        } else {
            return []byte("\n")
        }
    })

    var final bytes.Buffer
    for _, line := range bytes.Split(stripped, []byte("\n")) {
        if len(bytes.TrimSpace(line)) > 0 {
            final.WriteString(string(line) + "\n")
        }
    }

    return final.Bytes()
}

// stripYAMLDocDelimiter replaces YAML document delimiter with an empty line.
func StripYAMLDocDelimiter(src []byte) []byte {
    re := regexp.MustCompile(`(?m)^---\n`)
    return re.ReplaceAll(src, []byte("\n"))
}

// EnvSubst replaces occurrences of ${SOMETHING} with values from output
// in the content of the specified file. Returns the modified content.
func EnvSubst(filename string, envs map[string]string) (string, error) {
    // Read the content of the file
    content, err := ioutil.ReadFile(filename)
    if err != nil {
        return "", fmt.Errorf("failed to read file %s: %v", filename, err)
    }

    // Regular expression to match ${SOMETHING}
    re := regexp.MustCompile(`\$\{([^\}]+)\}`)

    // Replace occurrences with values from output
    modifiedContent := re.ReplaceAllStringFunc(string(content), func(match string) string {
        // Extract SOMETHING from ${SOMETHING}
        key := match[2 : len(match)-1]
        // Check if SOMETHING exists in output
        if value, ok := envs[key]; ok {
            return value
        }
        // If SOMETHING doesn't exist in output, return the original match
        return match
    })

    // Write the modified content back to the file
    err = ioutil.WriteFile(filename, []byte(modifiedContent), 0644)
    if err != nil {
        return "", fmt.Errorf("failed to write file %s: %v", filename, err)
    }

    return modifiedContent, nil
}

// EnvSubstRecursive applies EnvSubst to all files matching the regex pattern
// within the specified directory path (and its subdirectories).
func EnvSubstRecursive(rootPath string, regexPattern string, envs map[string]string) error {
    // Compile the regex pattern for filename matching
    re, err := regexp.Compile(regexPattern)
    if err != nil {
        return fmt.Errorf("failed to compile regex pattern: %v", err)
    }

    // Walk through the directory structure
    err = filepath.Walk(rootPath, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return fmt.Errorf("error accessing path %s: %v", path, err)
        }

        // Check if the file matches the regex pattern and is not a directory
        if !info.IsDir() && re.MatchString(info.Name()) {
            // Apply EnvSubst to the file
            _, err := EnvSubst(path, envs)
            if err != nil {
                return fmt.Errorf("error processing file %s: %v", path, err)
            }
            log.Info().Msgf("Processed file: %s\n", path)
        }

        return nil
    })

    if err != nil {
        return fmt.Errorf("error walking path %s: %v", rootPath, err)
    }

    return nil
}
