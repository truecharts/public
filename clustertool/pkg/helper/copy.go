package helper

import (
    "io"
    "os"
    "path/filepath"
    "regexp"
    "strings"

    "github.com/rs/zerolog/log"
)

// copyDirInternal copies files and directories from src to dest, preserving the directory structure.
// If replaceExisting is true, it will overwrite existing files in the destination.
// The filter string specifies files to be included (can be a regex pattern).
func copyDirInternal(src, dest string, replaceExisting bool, filter string) error {
    var regexFilter *regexp.Regexp
    var err error

    if filter != "" {
        // Compile filter string into regex pattern
        regexFilter, err = regexp.Compile(filter)
        if err != nil {
            return err
        }
    }

    err = filepath.Walk(src, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }

        // Determine the new path relative to the source directory
        relPath, err := filepath.Rel(src, path)
        if err != nil {
            return err
        }

        // Add debug output to verify the files being processed
        // log.Info().Msgf("Processing: %s\n", relPath)

        if regexFilter != nil && !regexFilter.MatchString(relPath) {
            // Skip files that do not match the regex filter
            if info.IsDir() {
                // log.Info().Msgf("Skipping directory (filtered): %s\n", relPath)
                return filepath.SkipDir // Skip entire directory if filtered out
            }
            // log.Info().Msgf("Skipping file (filtered): %s\n", relPath)
            return nil // Skip the file itself if filtered out
        }

        // Replace DOTREPLACE in the destination path
        destPath := filepath.Join(dest, relPath)
        destPath = ReplaceDotInFilename(destPath)

        if info.IsDir() {
            // If it's a directory, create the directory in the destination
            if err := os.MkdirAll(destPath, os.ModePerm); err != nil {
                return err
            }
        } else {
            // If it's a file, copy the file
            if _, err := os.Stat(destPath); os.IsNotExist(err) || replaceExisting {
                if err := CopyFile(path, destPath, replaceExisting); err != nil {
                    return err
                }
            } else {
                //log.Info().Msgf("Skipping existing file: %s\n", destPath)
            }
        }
        return nil
    })
    return err
}

// replaceDotInFilename replaces DOTREPLACE with a dot (.) in the given filename.
func ReplaceDotInFilename(filename string) string {
    return strings.ReplaceAll(filename, "DOTREPLACE", ".")
}

func CopyDir(src, dest string, replaceExisting bool) error {
    if err := copyDirInternal(src, dest, replaceExisting, ""); err != nil {
        return err
    }
    return nil
}

func CopyDirFiltered(src, dest string, replaceExisting bool, filter string) error {
    if err := copyDirInternal(src, dest, replaceExisting, filter); err != nil {
        return err
    }
    return nil
}

// CopyFile copies a file from source to destination. If replaceExisting is true, it will overwrite existing files in the destination.
func CopyFile(source, destination string, replaceExisting bool) error {
    if !replaceExisting {
        if _, err := os.Stat(destination); err == nil {
            log.Info().Msgf("Skipping existing file: %s\n", destination)
            return nil
        } else if !os.IsNotExist(err) {
            return err
        }
    }

    sourceFile, err := os.Open(source)
    if err != nil {
        return err
    }
    defer sourceFile.Close()

    destinationFile, err := os.Create(destination)
    if err != nil {
        return err
    }
    defer destinationFile.Close()

    _, err = io.Copy(destinationFile, sourceFile)
    return err
}
