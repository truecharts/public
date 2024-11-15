package sops

import (
    "bufio"
    "bytes"
    "fmt"
    "os"
    "path/filepath"
    "regexp"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "gopkg.in/yaml.v3"
)

// EncrFileData holds information about a file and its encryption status.
type EncrFileData struct {
    Path      string
    Encrypted bool
    Staged    bool
}

func ExecuteCheck(useStagedFiles bool) ([]EncrFileData, error) {
    log.Debug().Msg("Starting ExecuteCheck")

    // Step 1: Load the SOPS configuration.
    config, err := LoadSopsConfig()
    if err != nil {
        log.Error().Err(err).Msg("Failed to load SOPS config")
        return nil, err
    }
    log.Trace().Msg("SOPS configuration loaded successfully")

    // Step 2: Get the files from .sops.yaml configuration.
    allFiles, err := filesToCheck(config)
    if err != nil {
        log.Error().Err(err).Msg("Failed to get files to check")
        return nil, err
    }
    log.Debug().Msgf("Files to check: %v", allFiles)

    var filesToCheck []EncrFileData

    if useStagedFiles {
        // Step 3: Get the staged files from Git.
        stagedFiles, err := helper.GetStagedFiles()
        if err != nil {
            log.Error().Err(err).Msg("Failed to get staged files")
            return nil, err
        }

        if len(stagedFiles) == 0 {
            log.Warn().Msg("No staged files to check")
            return nil, fmt.Errorf("no staged files to check")
        }
        log.Info().Msgf("Staged files: %v", stagedFiles)

        // Step 4: Filter the .sops.yaml files to include only those that are staged.
        for _, file := range allFiles {
            checkPath := file.Path
            if _, err := os.Stat("./DEVTRIGGER"); err == nil {
                checkPath = filepath.Join("clustertool", checkPath)
            }
            for _, stagedFile := range stagedFiles {
                if checkPath == stagedFile {
                    filesToCheck = append(filesToCheck, file)
                    break
                }
            }
        }

        // Ensure that the files are fully staged by re-staging them.
        var filePaths []string
        for _, file := range filesToCheck {
            filePaths = append(filePaths, file.Path)
        }

        if err := helper.StageFiles(filePaths); err != nil {
            log.Error().Err(err).Msg("Error staging files")
            return nil, fmt.Errorf("error staging files: %v", err)
        }
        log.Info().Msg("All staged files processed successfully")
    } else {
        // Use all files instead of staged files.
        filesToCheck = allFiles
        log.Debug().Msgf("Using all files: %v", filesToCheck)
    }

    // Step 5: Check the encryption status of each file.
    for i, file := range filesToCheck {
        data, err := os.ReadFile(file.Path)
        if err != nil {
            log.Error().Err(err).Msgf("Error reading file %s", file.Path)
            return nil, fmt.Errorf("error reading file %s: %v", file.Path, err)
        }
        log.Trace().Msgf("Read file %s successfully", file.Path)

        // Check if the file is encrypted based on the criteria defined in .sops.yaml.
        filesToCheck[i].Encrypted = isEncrypted(data, file.Path)
        log.Debug().Msgf("File %s encrypted status: %v", file.Path, filesToCheck[i].Encrypted)
    }

    return filesToCheck, nil
}

func CheckFilesAndReportEncryption(tryEncrypt bool, checkStaged bool) error {
    log.Debug().Msg("Starting CheckFilesAndReportEncryption")

    // Step 1: Run the encryption check based on the toggle.
    files, err := ExecuteCheck(checkStaged)
    if err != nil {
        log.Error().Err(err).Msg("Error executing check")
        return fmt.Errorf("error executing check: %v", err)
    }

    // Step 2: Filter out unencrypted files.
    var unencryptedFiles []EncrFileData
    for _, file := range files {
        if !file.Encrypted {
            unencryptedFiles = append(unencryptedFiles, file)
        }
    }

    // Step 3: If there are any unencrypted files, handle based on the tryEncrypt flag.
    if len(unencryptedFiles) > 0 {
        log.Warn().Msg("Found unencrypted files")
        fmt.Println("The following files are not encrypted:")

        for _, file := range unencryptedFiles {
            fmt.Println(file.Path)

            // Step 4: If tryEncrypt is true, attempt to encrypt the files.
            if tryEncrypt {
                err := processFileEncryption(file)
                if err != nil {
                    log.Error().Err(err).Msgf("Failed to encrypt file %s", file.Path)
                } else {
                    log.Info().Msgf("File %s encrypted successfully.", file.Path)

                    // Step 5: Stage the file after successful encryption.
                    err := helper.StageFile(file.Path)
                    if err != nil {
                        log.Error().Err(err).Msgf("Failed to stage file %s after encryption", file.Path)
                    } else {
                        log.Info().Msgf("File %s staged successfully after encryption.", file.Path)
                    }
                }
            }
        }

        // If tryEncrypt is false, exit with failure code.
        if !tryEncrypt {
            log.Debug().Msg("tryEncrypt is false")
            log.Fatal().Msg("Exiting due to unencrypted files")

            os.Exit(1)
        } else {
            // Check if all files were successfully encrypted after the attempt.
            var stillUnencrypted []string
            for _, file := range unencryptedFiles {
                // Recheck encryption status after attempting to encrypt.
                data, err := os.ReadFile(file.Path)
                if err != nil {
                    log.Error().Err(err).Msgf("Error reading file %s", file.Path)
                    stillUnencrypted = append(stillUnencrypted, file.Path)
                    continue
                }
                if !isEncrypted(data, file.Path) {
                    stillUnencrypted = append(stillUnencrypted, file.Path)
                }
            }

            // If some files are still unencrypted, print them and exit with failure code.
            if len(stillUnencrypted) > 0 {
                log.Warn().Msg("The following files could not be encrypted:")
                fmt.Println("The following files could not be encrypted:")
                for _, file := range stillUnencrypted {
                    fmt.Println(file)
                }
                log.Fatal().Msg("Exiting due to unencrypted files after encryption attempt")
                os.Exit(1)
            }
            shamCheck()
        }
    }

    // Step 6: If no unencrypted files are found, print a success message and exit with code 0.
    log.Info().Msg("All files are encrypted.")
    fmt.Println("All files are encrypted.")
    os.Exit(0)

    return nil
}

// shamCheck checks if clusterenv contains the phrase "shamir_threshold" indicating it is indeed encrypted
func shamCheck() {
    log.Debug().Msg("Checking if clusterenv contains shamir_threshold to ensure encryption...")
    file, err := os.Open(helper.ClusterEnvFile)
    if err != nil {
        log.Error().Err(err).Msgf("error opening file: %w", err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        if strings.Contains(scanner.Text(), "shamir_threshold") {
            log.Debug().Msg("clusterenv contains shamir_threshold, continuing...")
            return
        }
    }

    if err := scanner.Err(); err != nil {
        log.Error().Err(err).Msgf("error reading file: %w", err)
    }

    log.Error().Msg("clusterenv is NOT encrypted and encryption-check failed!\n DO NOT UPLOAD!")
    os.Exit(1)
}

// filesToCheck returns a list of files to check for encryption based on the logic in .sops.yaml.
func filesToCheck(config SopsConfig) ([]EncrFileData, error) {
    log.Debug().Msg("Starting filesToCheck")

    // Ensure the config is loaded
    var files []EncrFileData
    // Iterate over each creation rule and find matching files
    for _, rule := range config.CreationRules {
        // Compile the path regex from the rule
        pathRegex, err := regexp.Compile(rule.PathRegex)
        if err != nil {
            log.Error().Err(err).Msg("Invalid path regex in .sops.yaml")
            return nil, fmt.Errorf("invalid path regex in .sops.yaml: %v", err)
        }

        // Find files that match the regex
        err = filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
            if err != nil {
                return err
            }
            if !info.IsDir() && pathRegex.MatchString(path) {
                files = append(files, EncrFileData{Path: path, Encrypted: false})
                log.Debug().Msgf("Matched file: %s", path)
            }
            return nil
        })
        if err != nil {
            log.Error().Err(err).Msg("Error walking file paths")
            return nil, err
        }
    }

    return files, nil
}

// isEncrypted checks if the given data is encrypted based on the criteria defined in .sops.yaml.
func isEncrypted(data []byte, filePath string) bool {
    log.Trace().Msgf("Checking if file %s is encrypted", filePath)
    // Detect the file format based on the file extension
    switch filepath.Ext(filePath) {
    case ".yaml", ".yml":
        return containsSopsField(data)
    case ".json":
        return containsSopsField(data)
    case ".env", ".ini":
        return containsEncMarker(data)
    default:
        return false
    }
}

func GetFormat(filePath string) string {
    log.Trace().Msgf("Getting format for file %s", filePath)
    switch filepath.Ext(filePath) {
    case ".yaml", ".yml":
        return "yaml"
    case ".json":
        return "json"
    case ".env":
        return "dotenv"
    case ".ini":
        return "ini"
    default:
        return "binary"
    }
}

// containsSopsField checks if the data contains the SOPS field.
func containsSopsField(data []byte) bool {
    log.Trace().Msg("Checking for SOPS field in data")
    var content map[string]interface{}
    if err := yaml.Unmarshal(data, &content); err != nil {
        // If the YAML is invalid, consider it not encrypted.
        return false
    }
    _, ok := content["sops"]
    return ok
}

// containsEncMarker checks if the data contains an encryption marker.
func containsEncMarker(data []byte) bool {
    log.Trace().Msg("Checking for encryption marker in data")
    return bytes.Contains(data, []byte("ENC["))
}
