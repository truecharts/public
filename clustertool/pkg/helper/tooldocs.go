package helper

import (
    "bufio"
    "fmt"
    "os"
    "path/filepath"
    "strings"

    "github.com/rs/zerolog/log"
)

func ToolDocs(tmpDir string, outputDir string) {
    log.Info().Msg("Starting file processing")

    if err := processFiles(tmpDir, outputDir); err != nil {
        log.Error().Err(err).Msg("Error processing files")
        return
    }
    if err := moveMatchingFilesToSubdirs(outputDir); err != nil {
        log.Error().Err(err).Msg("Error organizing files into subdirectories")
        return
    }

    renameClustertoolToIndex(outputDir)

    log.Info().Msg("File processing completed successfully")
}

// processFiles reads and processes each file, writing modified content to output directories.
func processFiles(tmpDir string, outputDir string) error {
    files, err := os.ReadDir(tmpDir)
    if err != nil {
        return fmt.Errorf("reading input directory: %w", err)
    }

    for _, file := range files {
        if file.IsDir() {
            log.Debug().Str("file", file.Name()).Msg("Skipping directory")
            continue
        }

        fileName := strings.Replace(file.Name(), "clustertool_", "", 1)
        subDir, newFileName := determinePaths(fileName)
        newPath := filepath.Join(outputDir, subDir, newFileName)

        log.Info().Str("file", file.Name()).Str("new_path", newPath).Msg("Processing file")

        content, err := os.ReadFile(filepath.Join(tmpDir, file.Name()))
        if err != nil {
            log.Error().Err(err).Str("file", file.Name()).Msg("Error reading file")
            continue
        }

        modifiedContent := addYamlTitle(content, newFileName == "index.md" && subDir == "")
        if err := writeToFile(newPath, modifiedContent, file); err != nil {
            log.Error().Err(err).Str("path", newPath).Msg("Error writing file")
            continue
        }

        if err := os.Remove(filepath.Join(tmpDir, file.Name())); err != nil {
            log.Error().Err(err).Str("file", file.Name()).Msg("Error deleting original file")
        } else {
            log.Debug().Str("file", file.Name()).Msg("Original file deleted")
        }
    }
    return nil
}

// determinePaths sets folder paths based on filename structure.
func determinePaths(filename string) (subDir, newFileName string) {
    parts := strings.SplitN(strings.TrimSuffix(filename, ".md"), "_", 2)
    if len(parts) < 2 {
        return "", filename
    }
    subDir = parts[0]
    newFileName = parts[1]
    if newFileName == subDir {
        newFileName = "index.md"
    } else {
        newFileName += ".md"
    }
    log.Debug().Str("sub_dir", subDir).Str("new_file", newFileName).Msg("Determined file paths")
    return
}

// addYamlTitle adds the YAML front matter with title and removes the "### SEE ALSO" section.
func addYamlTitle(content []byte, isPrimaryIndex bool) []byte {
    scanner := bufio.NewScanner(strings.NewReader(string(content)))
    var builder strings.Builder
    builder.WriteString("---\ntitle: ")

    if isPrimaryIndex {
        builder.WriteString("commands\n---\n")
        log.Debug().Msg("Set primary index title to 'commands'")
    } else if scanner.Scan() && strings.HasPrefix(scanner.Text(), "## ") {
        title := strings.TrimPrefix(scanner.Text(), "## ")
        if title == "clustertool" {
            title = "command"
        }
        title = strings.TrimPrefix(title, "clustertool ")
        builder.WriteString(title + "\n---\n")
        builder.WriteString(scanner.Text() + "\n")
        log.Debug().Str("title", title).Msg("Set title from first line")
    }

    // Add remaining lines until "### SEE ALSO" is found
    for scanner.Scan() {
        line := scanner.Text()
        if strings.HasPrefix(line, "### SEE ALSO") {
            log.Debug().Msg("Skipping 'SEE ALSO' section")
            break
        }
        builder.WriteString(line + "\n")
    }

    return []byte(builder.String())
}

// writeToFile writes the content to the specified path, creating directories as needed.
func writeToFile(path string, content []byte, file os.DirEntry) error {
    if err := os.MkdirAll(filepath.Dir(path), os.ModePerm); err != nil {
        return fmt.Errorf("creating directory for path %s: %w", path, err)
    }
    if err := os.WriteFile(path, content, file.Type()); err != nil {
        return fmt.Errorf("writing file to path %s: %w", path, err)
    }

    // Set file permissions to 777
    if err := os.Chmod(path, 0666); err != nil {
        return fmt.Errorf("setting permissions for path %s: %w", path, err)
    }

    log.Info().Str("path", path).Msg("File written successfully")
    return nil
}

// moveMatchingFilesToSubdirs moves files to matching subdirectories as index.md if a subdirectory exists.
func moveMatchingFilesToSubdirs(outputDir string) error {
    files, err := os.ReadDir(outputDir)
    if err != nil {
        return fmt.Errorf("reading output directory: %w", err)
    }

    for _, file := range files {
        if file.IsDir() {
            continue
        }

        fileBase := strings.TrimSuffix(file.Name(), ".md")
        subDir := filepath.Join(outputDir, fileBase)
        if info, err := os.Stat(subDir); err == nil && info.IsDir() {
            newPath := filepath.Join(subDir, "index.md")
            if err := os.Rename(filepath.Join(outputDir, file.Name()), newPath); err != nil {
                log.Error().Err(err).Str("file", file.Name()).Str("new_path", newPath).Msg("Error moving file to subdirectory")
                return err
            }
            log.Info().Str("file", file.Name()).Str("subdirectory", subDir).Msg("Moved file to subdirectory as index.md")
        }
    }
    return nil
}

// renameClustertoolToIndex renames clustertool.md to index.md in the given directory.
func renameClustertoolToIndex(dir string) error {
    oldPath := filepath.Join(dir, "clustertool.md")
    newPath := filepath.Join(dir, "index.md")

    // Check if clustertool.md exists
    if _, err := os.Stat(oldPath); os.IsNotExist(err) {
        log.Warn().Str("file", oldPath).Msg("clustertool.md does not exist")
        return nil // No error, just return since file doesn't exist
    }

    // Rename clustertool.md to index.md
    if err := os.Rename(oldPath, newPath); err != nil {
        return fmt.Errorf("renaming %s to %s: %w", oldPath, newPath, err)
    }

    log.Info().Str("old_path", oldPath).Str("new_path", newPath).Msg("File renamed successfully")
    return nil
}
