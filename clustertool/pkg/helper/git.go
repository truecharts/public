package helper

import (
    "bytes"
    "fmt"
    "os"
    "os/exec"
    "path/filepath"
    "runtime"
    "strings"

    "github.com/rs/zerolog/log"
)

// getStagedFiles lists all files that are staged for commit
func GetStagedFiles() ([]string, error) {
    // Run git diff --cached --name-only to get staged files
    cmd := exec.Command("git", "diff", "--cached", "--name-only")

    var out bytes.Buffer
    cmd.Stdout = &out

    if err := cmd.Run(); err != nil {
        return nil, fmt.Errorf("failed to run git command: %v", err)
    }

    // Split the output into lines (file names)
    output := strings.TrimSpace(out.String())
    if output == "" {
        return nil, nil
    }

    files := strings.Split(output, "\n")
    return files, nil
}

func StageFiles(files []string) error {
    for _, file := range files {
        // Stage the file using `git add <file>`
        cmd := exec.Command("git", "add", file)
        if err := cmd.Run(); err != nil {
            return fmt.Errorf("failed to stage file %s: %v", file, err)
        }
    }
    return nil
}

//////

// StageFile stages the given file using `git add`
func StageFile(filePath string) error {
    cmd := exec.Command("git", "add", filePath)
    var out bytes.Buffer
    cmd.Stdout = &out
    err := cmd.Run()
    if err != nil {
        return fmt.Errorf("error staging file: %v", err)
    }
    return nil
}

// GetGitStagedFiles returns a list of git-staged files, excluding ignored files.
func GetGitStagedFiles() ([]string, error) {
    // Get the list of staged files
    cmd := exec.Command("git", "diff", "--cached", "--name-only")
    var out bytes.Buffer
    cmd.Stdout = &out
    if err := cmd.Run(); err != nil {
        return nil, err
    }

    // Split the output into a slice of file names
    files := strings.Split(strings.TrimSpace(out.String()), "\n")

    return files, nil
}

// IsFileIgnored checks if a file is ignored by Git.
func IsFileIgnored(file string) (bool, error) {
    // Check if the file is ignored as-is
    ignored, err := checkIgnore(file)
    if err != nil {
        return false, err // Return error if checking fails
    }
    if ignored {
        return true, nil // Return true if the file is ignored as-is
    }

    // Check if the file is ignored with "clustertool/" prefix
    prefixedFile := "clustertool/" + file
    ignored, err = checkIgnore(prefixedFile)
    if err != nil {
        return false, err // Return error if checking fails
    }

    return ignored, nil // Return the result of the prefixed check
}

// checkIgnore is a helper function that runs the git check-ignore command for a given file.
func checkIgnore(file string) (bool, error) {
    // Define the base folder to check
    devTrigger := "DEVTRIGGER"

    // Check if the directory exists
    if _, err := os.Stat(devTrigger); !os.IsNotExist(err) {

        // If the directory exists, skip checks for specified paths
        // Check if the file path starts with the specified prefixes
        if isPathIgnored(file, []string{
            "repositories",
            "clusters",
            "clustertool/repositories",
            "clustertool/clusters",
        }) {
            return true, nil // Skip ignoring check
        }
    }

    // Run the git check-ignore command for the given file
    cmd := exec.Command("git", "check-ignore", file)
    if err := cmd.Run(); err != nil {
        // If the error is an ExitError, check the exit code
        if exitError, ok := err.(*exec.ExitError); ok {
            if exitError.ExitCode() == 1 {
                // The file is ignored (exit code 1 indicates that the file is ignored)
                return true, nil
            }
        }
        // If there's another error, return it
        return false, err
    }
    // If the command succeeds (exit code 0), the file is not ignored
    return false, nil
}

// isPathIgnored checks if the file path starts with any of the specified prefixes.
func isPathIgnored(file string, prefixes []string) bool {
    for _, prefix := range prefixes {
        // Use filepath.HasPrefix to check if the file path starts with the prefix
        if filepath.HasPrefix(file, prefix) {
            return true
        }
    }
    return false
}

// IsFileFullyStaged checks if a file is fully staged (no pending unstaged changes)
// for both the unprefixed path and the path prefixed with /clustertool.
// It ignores files that are listed in .gitignore.
func IsFileFullyStaged(filePath string) (bool, error) {
    // Get the Git root directory
    cmd := exec.Command("git", "rev-parse", "--show-toplevel")
    var out bytes.Buffer
    cmd.Stdout = &out
    err := cmd.Run()
    if err != nil {
        return false, err
    }
    gitRoot := strings.TrimSpace(out.String())

    // Check if the clustertool directory exists in the Git root
    clustertoolPath := filepath.Join(gitRoot, "clustertool")
    _, err = exec.Command("test", "-d", clustertoolPath).Output()
    clustertoolExists := (err == nil)

    // Create a slice of file paths to check
    filePaths := []string{filePath}
    if clustertoolExists {
        filePaths = append(filePaths, "clustertool/"+filePath)
    }

    // Check if the files are ignored
    for _, path := range filePaths {
        ignoredCmd := exec.Command("git", "check-ignore", path)
        var ignoredOut bytes.Buffer
        ignoredCmd.Stdout = &ignoredOut
        err := ignoredCmd.Run()
        if err == nil {
            // If there's no error, the file is ignored
            continue // Skip this file since it's ignored
        }

        // If the file is not ignored, check for unstaged changes
        diffCmd := exec.Command("git", "diff", path) // Check for unstaged changes
        var diffOut bytes.Buffer
        diffCmd.Stdout = &diffOut
        err = diffCmd.Run()
        if err != nil {
            return false, err
        }

        // If there's output from git diff, it means there are unstaged changes
        if strings.TrimSpace(diffOut.String()) != "" {
            return false, nil // Found unstaged changes
        }
    }

    // If no unstaged changes were found for both paths and files were not ignored
    return true, nil
}

// IsCurrentDirGitRepo checks if the current directory is a Git repository.
func IsCurrentDirGitRepo() (bool, error) {
    // Get the current working directory
    dir, err := os.Getwd()
    if err != nil {
        return false, err
    }

    // Construct the path to the .git directory
    gitDir := filepath.Join(dir, ".git")

    // Check if the .git directory exists and is a directory
    info, err := os.Stat(gitDir)
    if os.IsNotExist(err) {
        return false, nil
    }
    if err != nil {
        return false, err
    }
    return info.IsDir(), nil
}

// CreateEncrPreCommitHook creates a pre-commit hook script in the .git/hooks directory
func CreateEncrPreCommitHook() error {
    isRepo, err := IsCurrentDirGitRepo()
    if err != nil {
        return fmt.Errorf("error checking if current directory is a Git repository: %v", err)
    } else if isRepo {
        log.Info().Msg("Bootstrap: The current directory is a valid GIT repository, creating precommit hook...")
    } else {
        log.Info().Msg("The current directory is not a valid GIT repository. Skipping precommit hook creation...")
        return nil
    }

    // Get the current working directory
    dir, err := os.Getwd()
    if err != nil {
        return fmt.Errorf("could not get current working directory: %v", err)
    }

    // Define the path to the .git/hooks directory
    hooksDir := filepath.Join(dir, ".git", "hooks")
    var hookPath string

    if runtime.GOOS == "windows" {
        hookPath = filepath.Join(hooksDir, "pre-commit.bat")
    } else {
        hookPath = filepath.Join(hooksDir, "pre-commit")
    }

    // Define the script path
    filename := "precommit"
    scriptPath := filepath.Join(CacheDir, filename)
    var hookScript string

    // Check if go.mod exists to decide on the script content
    goModPath := filepath.Join(dir, "go.mod")
    if _, err := os.Stat(goModPath); !os.IsNotExist(err) {
        // If go.mod exists, use `go run . checkcrypt`
        hookScript = fmt.Sprintf(`#!/bin/sh
# Pre-commit hook script

# Use go run . checkcrypt if go.mod exists
echo "Running pre-commit encryption check..."
# go run . checkcrypt
if [ $? -ne 0 ]; then
    echo "Pre-commit encryption check failed. Commit aborted."
    exit 1
fi
`)
    } else {
        // Otherwise, use the file
        switch runtime.GOOS {
        case "windows":
            // On Windows, the script must be a batch file or similar executable
            scriptPath = filepath.ToSlash(scriptPath) // Ensure path format is correct for Windows
            // Add .exe suffix for Windows
            scriptPath = scriptPath + ".exe"
            hookScript = fmt.Sprintf(`@echo off
REM Pre-commit hook script

REM Path to the script to run
set scriptPath=%s

REM Check if the script exists
if exist "%%scriptPath%%" (
    echo Running pre-commit script...
    "%%scriptPath%%"
    if errorlevel 1 (
        echo Pre-commit script failed. Commit aborted.
        exit /b 1
    )
) else (
    echo Script %%scriptPath%% not found. Commit aborted.
    exit /b 1
)
`, scriptPath)

        default:
            // For Unix-like systems: Linux, macOS, and FreeBSD
            hookScript = fmt.Sprintf(`#!/bin/sh
# Pre-commit hook script

# Check if the script exists and is executable
if [ -x "%s" ]; then
    echo "Running pre-commit script..."
    "%s"
    if [ $? -ne 0 ]; then
        echo "Pre-commit script failed. Commit aborted."
        exit 1
    fi
else
    echo "Script %s not found or not executable. Commit aborted."
    exit 1
fi
`, scriptPath, scriptPath, scriptPath)
        }
    }

    // Create or overwrite the pre-commit hook file
    file, err := os.Create(hookPath)
    if err != nil {
        return fmt.Errorf("could not create pre-commit hook file: %v", err)
    }
    defer file.Close()

    // Write the script content to the file
    _, err = file.WriteString(hookScript)
    if err != nil {
        return fmt.Errorf("could not write to pre-commit hook file: %v", err)
    }

    // Make the hook script executable on Unix-like systems
    if runtime.GOOS != "windows" {
        err = os.Chmod(hookPath, 0755)
        if err != nil {
            return fmt.Errorf("could not make pre-commit hook executable: %v", err)
        }
    }

    log.Info().Msg("Pre-commit hook created successfully.")
    return nil
}
