package sops

import (
    "fmt"
    "os"
    "regexp"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

// EncryptAllFiles encrypts all unencrypted files as specified in the .sops.yaml configuration.
func EncryptAllFiles() error {
    log.Trace().Msg("Starting EncryptAllFiles function")

    files, err := ExecuteCheck(false) // Get the list of files and their encryption status
    if err != nil {
        log.Error().Err(err).Msg("Failed to execute check for file statuses")
        return err
    }

    log.Debug().Int("fileCount", len(files)).Msg("Found files to process for encryption")

    for _, file := range files {
        if err := processFileEncryption(file); err != nil {
            log.Error().Err(err).Msgf("Error processing encryption for file: %s", file.Path)
            return err
        }
    }

    log.Info().Msg("All Files encrypted successfully")
    return nil
}

// Helper function that handles the encryption process for an individual file
func processFileEncryption(file EncrFileData) error {
    // Skip files that are already encrypted
    if file.Encrypted {
        log.Info().Msgf("File %s is already encrypted, skipping.\n", file.Path)
        return nil
    }

    // Check if the file is partially staged
    fullyStaged, err := helper.IsFileFullyStaged(file.Path)
    if err != nil {
        log.Error().Err(err).Msgf("Error checking staged status of file: %s", file.Path)
        return fmt.Errorf("error checking staged status of file %s: %v", file.Path, err)
    }

    // If the file is not fully staged, stage it
    if !fullyStaged {
        log.Info().Msgf("File %s is partially staged, staging fully...\n", file.Path)
        err := helper.StageFile(file.Path)
        if err != nil {
            log.Error().Err(err).Msgf("Error staging file: %s", file.Path)
            return fmt.Errorf("error staging file %s: %v", file.Path, err)
        }
        log.Info().Msgf("File %s fully staged.\n", file.Path)
    }

    // Encrypt the file
    err = encryptFile(file.Path)
    if err != nil {
        log.Error().Err(err).Msgf("Error encrypting file: %s", file.Path)
        return fmt.Errorf("error encrypting file %s: %v", file.Path, err)
    }

    log.Debug().Msgf("File %s encrypted successfully.\n", file.Path)
    return nil
}

// encryptFile encrypts the content of the specified file and replaces the file with the encrypted data.
func encryptFile(filePath string) error {
    log.Trace().Msgf("Starting encryption for file: %s", filePath)

    // Read the content of the file
    content, err := os.ReadFile(filePath)
    log.Debug().Msgf("Encrypting '%s'... \n", filePath)
    if err != nil {
        log.Error().Err(err).Msg("Error reading file")
        return fmt.Errorf("error reading file: %v", err)
    }

    // Ensure the regex covers the whole content
    sopsConfig, err := LoadSopsConfig()
    if err != nil {
        log.Error().Err(err).Msg("Error loading SOPS configuration")
        return err
    }

    encrRegex := mergeRegex(filePath, sopsConfig)

    // Encrypt the content
    encryptedData, err := EncryptWithAgeKey(content, encrRegex, GetFormat(filePath))
    if err != nil {
        log.Error().Err(err).Msg("Error encrypting data")
        return fmt.Errorf("error encrypting data: %v", err)
    }

    // Write the encrypted data back to the file
    if err := os.WriteFile(filePath, encryptedData, 0644); err != nil {
        log.Error().Err(err).Msg("Error writing encrypted data to file")
        return fmt.Errorf("error writing encrypted data to file: %v", err)
    }

    log.Debug().Msgf("Successfully encrypted file: %s", filePath)
    return nil
}

// mergeRegex merges regex from the SOPS configuration.
func mergeRegex(filePath string, config SopsConfig) string {
    log.Trace().Msgf("Merging regex for file: %s", filePath)

    // Initialize an empty string for merged regex
    mergedRegex := ""

    // Iterate through each creation rule
    for _, rule := range config.CreationRules {
        // Compile the regex pattern
        r, err := regexp.Compile(rule.PathRegex)
        if err != nil {
            log.Warn().Err(err).Msg("Error compiling regex")
            continue
        }

        // Check if the given path matches the current rule's path regex
        if r.MatchString(filePath) {
            // Merge the encrypted regex into the mergedRegex string
            mergedRegex += rule.EncryptedRegex + "|"
            log.Debug().Msgf("File %s matched regex, adding encrypted regex: %s", filePath, rule.EncryptedRegex)
        }
    }

    // Remove the trailing "|" if mergedRegex is not empty
    if mergedRegex != "" {
        mergedRegex = mergedRegex[:len(mergedRegex)-1]
        log.Debug().Msgf("Merged regex for file %s: %s", filePath, mergedRegex)
    }

    return mergedRegex
}
