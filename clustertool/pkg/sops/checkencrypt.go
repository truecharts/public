package sops

import (
	"bytes"
	"fmt"
	"os"
	"path/filepath"
	"regexp"

	"github.com/rs/zerolog/log"
	"github.com/truecharts/private/clustertool/pkg/helper"
	"sigs.k8s.io/yaml"
)

// EncrFileData holds information about a file and its encryption status.
type EncrFileData struct {
	Path      string
	Encrypted bool
	Staged    bool
}

func ExecuteCheck(useStagedFiles bool) ([]EncrFileData, error) {
	// Step 1: Load the SOPS configuration.
	config, err := LoadSopsConfig()
	if err != nil {
		return nil, err
	}

	// Step 2: Get the files from .sops.yaml configuration.
	allFiles, err := filesToCheck(config)
	if err != nil {
		return nil, err
	}

	var filesToCheck []EncrFileData

	if useStagedFiles {
		// Step 3: Get the staged files from Git.
		stagedFiles, err := helper.GetStagedFiles()
		if err != nil {
			return nil, err
		}

		if len(stagedFiles) == 0 {
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
			return nil, fmt.Errorf("error staging files: %v", err)
		}
	} else {
		// Use all files instead of staged files.
		filesToCheck = allFiles
		// log.Info().Msgf("All files: %v", filesToCheck)
	}

	// Step 5: Check the encryption status of each file.
	for i, file := range filesToCheck {
		data, err := os.ReadFile(file.Path)
		if err != nil {
			return nil, fmt.Errorf("error reading file %s: %v", file.Path, err)
		}

		// Check if the file is encrypted based on the criteria defined in .sops.yaml.
		filesToCheck[i].Encrypted = isEncrypted(data, file.Path)
	}

	return filesToCheck, nil
}

func CheckFilesAndReportEncryption(tryEncrypt bool, checkStaged bool) error {
	// Step 1: Run the encryption check based on the toggle.
	files, err := ExecuteCheck(checkStaged)
	if err != nil {
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
		fmt.Println("The following files are not encrypted:")

		for _, file := range unencryptedFiles {
			fmt.Println(file.Path)

			// Step 4: If tryEncrypt is true, attempt to encrypt the files.
			if tryEncrypt {
				err := processFileEncryption(file)
				if err != nil {
					log.Error().Msgf("Failed to encrypt file %s: %v", file.Path, err)
				} else {
					log.Info().Msgf("File %s encrypted successfully.", file.Path)

					// Step 5: Stage the file after successful encryption.
					err := helper.StageFile(file.Path)
					if err != nil {
						log.Error().Msgf("Failed to stage file %s after encryption: %v", file.Path, err)
					} else {
						log.Info().Msgf("File %s staged successfully after encryption.", file.Path)
					}
				}
			}
		}

		// If tryEncrypt is false, exit with failure code.
		if !tryEncrypt {
			os.Exit(1)
		} else {
			// Check if all files were successfully encrypted after the attempt.
			var stillUnencrypted []string
			for _, file := range unencryptedFiles {
				// Recheck encryption status after attempting to encrypt.
				data, err := os.ReadFile(file.Path)
				if err != nil {
					log.Error().Msgf("Error reading file %s: %v", file.Path, err)
					stillUnencrypted = append(stillUnencrypted, file.Path)
					continue
				}
				if !isEncrypted(data, file.Path) {
					stillUnencrypted = append(stillUnencrypted, file.Path)
				}
			}

			// If some files are still unencrypted, print them and exit with failure code.
			if len(stillUnencrypted) > 0 {
				fmt.Println("The following files could not be encrypted:")
				for _, file := range stillUnencrypted {
					fmt.Println(file)
				}
				os.Exit(1)
			}
		}
	}

	// Step 6: If no unencrypted files are found, print a success message and exit with code 0.
	fmt.Println("All files are encrypted.")
	os.Exit(0)

	return nil
}

// filesToCheck returns a list of files to check for encryption based on the logic in .sops.yaml.
func filesToCheck(config SopsConfig) ([]EncrFileData, error) {
	// Ensure the config is loaded

	var files []EncrFileData
	// Iterate over each creation rule and find matching files
	for _, rule := range config.CreationRules {
		// Compile the path regex from the rule
		pathRegex, err := regexp.Compile(rule.PathRegex)
		if err != nil {
			return nil, fmt.Errorf("invalid path regex in .sops.yaml: %v", err)
		}

		// Find files that match the regex
		err = filepath.Walk(".", func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			if !info.IsDir() && pathRegex.MatchString(path) {
				files = append(files, EncrFileData{Path: path, Encrypted: false})
			}
			return nil
		})
		if err != nil {
			return nil, err
		}
	}

	return files, nil
}

// isEncrypted checks if the given data is encrypted based on the criteria defined in .sops.yaml.
func isEncrypted(data []byte, filePath string) bool {
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

// containsSopsField checks for the presence of the "sops" field in YAML or JSON data.
func containsSopsField(data []byte) bool {
	var content map[string]interface{}
	if err := yaml.Unmarshal(data, &content); err != nil {
		// If the YAML is invalid, consider it not encrypted.
		return false
	}
	_, ok := content["sops"]
	return ok
}

// containsEncMarker checks for the presence of "ENC[" marker in ENV or INI data.
func containsEncMarker(data []byte) bool {
	return bytes.Contains(data, []byte("ENC["))
}
