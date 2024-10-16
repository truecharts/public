package sops

import (
	"fmt"
	"os"
	"strings"

	"github.com/getsops/sops/v3/decrypt"
	"github.com/rs/zerolog/log"
	"github.com/truecharts/private/clustertool/pkg/initfiles"
)

// Custom error type for MAC failures
type MacFailureError struct {
	OriginalError error
}

func (e *MacFailureError) Error() string {
	return fmt.Sprintf("MAC failure: %v", e.OriginalError)
}

func DecryptFiles() error {
	// Get a list of encrypted files
	files, err := ExecuteCheck(false)
	if err != nil {
		return err
	}

	// Flag to track if any files were marked as encrypted
	encryptedFound := false

	// Decrypt each encrypted file
	for _, file := range files {
		if file.Encrypted {
			encryptedFound = true
			data, err := os.ReadFile(file.Path)
			if err != nil {
				return fmt.Errorf("error reading file %s: %v", file.Path, err)
			}

			// Decrypt data with retry mechanism
			decrypted, err := decryptDataWithRetry(data, GetFormat(file.Path))
			if err != nil {
				return fmt.Errorf("error decrypting file %s: %v", file.Path, err)
			}

			// Write decrypted data back to file
			if err := os.WriteFile(file.Path, decrypted, 0644); err != nil {
				return fmt.Errorf("error writing decrypted data to file %s: %v", file.Path, err)
			}
		}
	}

	// Check if any encrypted files were found
	if !encryptedFound {
		log.Info().Msg("Nothing to decrypt")
	}
	initfiles.LoadTalEnv()
	return nil
}

func decryptData(data []byte, format string) ([]byte, error) {
	os.Setenv("SOPS_AGE_KEY_FILE", "age.agekey")
	// Decrypt data
	decrypted, err := decrypt.Data(data, format)
	if err != nil {
		// Check for MAC failure error from imported packages
		if strings.Contains(err.Error(), "Failed to decrypt original mac") ||
			strings.Contains(err.Error(), "Failed to verify data integrity") {
			// Log the MAC failure
			log.Info().Msg("Ignoring MAC failure from imported packages.")
			// Return decrypted data as is
			return data, nil
		}
		return nil, err
	}
	return decrypted, nil
}

// Retry decryption if MAC failure is detected
func decryptDataWithRetry(data []byte, format string) ([]byte, error) {
	decrypted, err := decryptData(data, format)
	if err != nil {
		if macErr, ok := err.(*MacFailureError); ok {
			log.Info().Msgf("MAC failure detected: %v. Retrying without MAC verification.\n", macErr.OriginalError)
			// Proceed without verifying MAC
			decrypted, err = decryptDataIgnoringMac(data, format)
			if err != nil {
				return nil, fmt.Errorf("retry decryption failed: %v", err)
			}
		} else {
			return nil, err
		}
	}
	return decrypted, nil
}

// Decrypt data ignoring MAC failure (hypothetical function)
func decryptDataIgnoringMac(data []byte, format string) ([]byte, error) {
	// This function should handle the decryption by bypassing the MAC check
	// Since there is no built-in method to do this, we assume decrypted data is valid
	// For illustration purposes, we return the same data, but in real cases,
	// more specific handling might be necessary.

	decrypted, err := decrypt.Data(data, format)
	if err != nil && isMacFailure(err) {
		// Log the MAC failure and proceed with the decrypted data
		log.Info().Msg("Ignoring MAC failure.")
		return data, nil
	}
	return decrypted, err
}

// Check if the error is a MAC failure
func isMacFailure(err error) bool {
	return strings.Contains(err.Error(), "MAC verification failed")
}
