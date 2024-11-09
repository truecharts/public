package initfiles

import (
    "bufio"
    "errors"
    "fmt"
    "io/ioutil"
    "os"
    "path"
    "path/filepath"
    "regexp"
    "strings"
    "time"

    "github.com/rs/zerolog/log"
    "gopkg.in/yaml.v3"

    age "filippo.io/age"
    "github.com/truecharts/public/clustertool/pkg/fluxhandler"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/talassist"
    corev1 "k8s.io/api/core/v1"
)

func InitFiles() error {
    removeRunAgainFile()
    ageGen()
    genRootFiles()
    genBaseFiles()
    UpdateRootFiles()
    UpdateBaseFiles()
    talassist.GenSchema()
    GenPatches()
    genKubernetes()
    GenTalEnvConfigMap()
    UpdateGitRepo()
    fluxhandler.CreateGitSecret(helper.TalEnv["GITHUB_REPOSITORY"])
    GenSopsSecret()
    if err := fluxhandler.ProcessDirectory(path.Join(helper.ClusterPath, "kubernetes")); err != nil {
        log.Error().Msgf("Error: %v", err)
    }
    if err := fluxhandler.ProcessDirectory(path.Join(helper.ClusterPath, "kubernetes")); err != nil {
        log.Error().Msgf("Error: %v", err)
    } else {
        log.Info().Msg("Kustomizations processed successfully.")
    }

    helper.CreateEncrPreCommitHook()
    log.Info().Msg("Init: Completed Successfully!")
    return nil
}

func genKubernetes() error {

    err := helper.CopyDir(helper.KubeCache, helper.ClusterPath+"/kubernetes", false)
    if err != nil {
        log.Info().Msgf("Error: %v", err)
    } else {
        log.Info().Msgf("Kubernetes files copied successfully.")
    }

    helper.ReplaceInFile(path.Join(helper.ClusterPath, "/kubernetes/flux-entry.yaml"), "REPLACEWITHCLUSTERNAME", helper.ClusterName)
    if err != nil {
        log.Fatal().Err(err).Msgf("Error: %s", err)
    }

    return nil
}

func GenTalEnvConfigMap() error {

    log.Info().Msg("Creating TalEnv configmap reference 'clustersettings'.")
    // Read the content of the talenv.yaml file
    talenvContent, err := os.ReadFile(helper.ClusterEnvFile)
    if err != nil {
        return err
    }

    // Convert the file content to a string and split it into lines
    talenvLines := strings.Split(string(talenvContent), "\n")

    // Add indentation to each line
    for i, line := range talenvLines {
        talenvLines[i] = "  " + line
    }
    indentClusterName := "  CLUSTERNAME: " + helper.ClusterName
    talenvLines = append(talenvLines, indentClusterName)

    // Join the indented lines back into a single string
    indentedTalenvContent := strings.Join(talenvLines, "\n")

    clusterSettings := filepath.Join("flux-system", "flux", "clustersettings.secret.yaml")
    clusterSettingsDest := filepath.Join(helper.ClusterPath+"/kubernetes", clusterSettings)
    clusterSettingsSrc := filepath.Join(helper.KubeCache, clusterSettings)
    os.MkdirAll(filepath.Join(helper.ClusterPath, "/kubernetes", "flux-system", "flux"), os.ModePerm)
    err = helper.CopyFile(clusterSettingsSrc, clusterSettingsDest, true)
    log.Debug().Msgf("clusterSettingsDest %v", clusterSettingsDest)
    helper.ReplaceInFile(clusterSettingsDest, "REPLACEWITHENV", indentedTalenvContent)
    if err != nil {
        log.Fatal().Err(err).Msg("Error: %s")
    }
    log.Info().Msg("Configmap reference Created.")
    return nil
}

func UpdateGitRepo() {
    if helper.TalEnv["GITHUB_REPOSITORY"] != "" {
        repoPath := filepath.Join("repositories", "git", "this-repo.yaml")
        gitrepo := FormatGitURL(helper.TalEnv["GITHUB_REPOSITORY"])
        helper.ReplaceInFile(repoPath, "ssh://REPLACEWITHGITREPO", gitrepo)
    }
}

// FormatGitURL formats the input Git URL according to the specified rules.
func FormatGitURL(input string) string {
    // Remove "https://" prefix if present
    input = strings.TrimPrefix(input, "https://")

    if !strings.HasPrefix(input, "ssh://") {
        input = "ssh://" + input
    }

    // Ensure input starts with "ssh://git@"
    if !strings.HasPrefix(input, "ssh://git@") {
        // Prepend "ssh://git@" if neither "ssh://" nor "git@" is present
        input = strings.Replace(input, "ssh://", "ssh://git@", 1)
    }

    if strings.Contains(input, "git@git@") {
        input = strings.Replace(input, "git@git@", "git@", 1)
    }

    // Compile a regex to match and replace the URL pattern
    re := regexp.MustCompile(`^ssh://git@([^:/]+)([:/])([\w-]+)/([\w-]+)\.git$`)
    matches := re.FindStringSubmatch(input)

    if len(matches) == 5 {
        // Determine the user and repo based on the separator used
        user := matches[3] // Always captured as part of the matched group
        repo := matches[4] // Always captured as part of the matched group
        return fmt.Sprintf("ssh://git@%s/%s/%s.git", matches[1], user, repo)
    }

    return input // Return the input as is if it doesn't match
}

func genBaseFiles() error {
    clusterEnvPresent := false

    if _, err := os.Stat(helper.ClusterEnvFile); err == nil {
        clusterEnvPresent = true
        log.Debug().Msg("Detected existing cluster, continuing")
    } else if os.IsNotExist(err) {
        createRunAgainFile()
        log.Warn().Msg("New cluster detected, creating clusterenv.yaml\n Please fill out ClusterEnv.yaml and run init again, after setting-up clusterenv.yaml!")
    } else {
        log.Fatal().Err(err).Msgf("Error checking clusterenv file: %s", err)
        return err
    }

    err := helper.CopyDir(helper.BaseCache, helper.ClusterPath+"", false)
    if err != nil {
        log.Error().Msgf("Error: %v", err)
    } else {
        log.Info().Msg("Base files copied successfully.")
    }

    if !clusterEnvPresent {
        os.Exit(0)
    }

    log.Info().Msg("basefiles successfully altered.")
    return nil
}

// Create the "RUNAGAIN" file
func createRunAgainFile() {
    file, err := os.Create("RUNAGAIN")
    if err != nil {
        log.Err(err).Msg("error creating runagain file...")
        return
    }
    defer file.Close()
    return
}

// Remove the "RUNAGAIN" file if it exists
func removeRunAgainFile() error {
    if CheckRunAgainFileExists() {
        err := os.Remove("RUNAGAIN")
        if err != nil {
            log.Err(err).Msg("error removing runagain file...")
            return err
        }
        log.Debug().Msg("RUNAGAIN file removed.")
    } else {
        log.Debug().Msg("RUNAGAIN file does not exist.")
    }
    return nil
}

// Check if the "RUNAGAIN" file exists
func CheckRunAgainFileExists() bool {
    _, err := os.Stat("RUNAGAIN")
    return !os.IsNotExist(err)
}

func UpdateBaseFiles() error {
    log.Info().Msg("Updating Base files for cluster: helper.ClusterPath")
    // Read filenames in source directory
    sourceFiles, err := readFilenamesInDir(helper.BaseCache)
    if err != nil {
        log.Info().Msgf("Error reading source directory: %v\n", err)
        return err
    }

    // Process each file in the target directory
    for _, filename := range sourceFiles {
        sourceFilePath := filepath.Join(helper.BaseCache, filename)
        targetFilePath := filepath.Join(helper.ClusterPath+"", helper.ReplaceDotInFilename(filename))
        helper.ReplaceContentBetweenLines(targetFilePath, sourceFilePath, "## Do not edit between this and DO NOT REMOVE", "## DO NOT REMOVE: Personal setting go under this line")
    }
    log.Info().Msg("basefiles successfully updated.")

    CheckEnvVariables()

    return nil

}

func genRootFiles() error {

    err := helper.CopyDir(helper.RootCache, "./", false)
    if err != nil {
        log.Info().Msgf("Error: %v", err)
    } else {
        log.Info().Msg("Root files copied successfully.")
    }

    agePubKey, err := GetPubKey()
    if err != nil {
        log.Fatal().Err(err).Msg("error: %v")
    }
    log.Info().Msgf("Public Key: %v", agePubKey)
    helper.ReplaceInFile(".sops.yaml", "REPLACEME", agePubKey)
    if err != nil {
        log.Fatal().Err(err).Msg("Error: %s")
    }

    log.Info().Msg("basefiles successfully altered.")
    return nil
}

func UpdateRootFiles() error {
    // Read filenames in source directory
    sourceFiles, err := readFilenamesInDir(helper.RootCache)
    if err != nil {
        log.Info().Msgf("Error reading source directory: %v\n", err)
        return err
    }

    // Process each file in the target directory
    for _, filename := range sourceFiles {
        sourceFilePath := filepath.Join(helper.BaseCache, filename)
        targetFilePath := filepath.Join("./", helper.ReplaceDotInFilename(filename))
        helper.ReplaceContentBetweenLines(targetFilePath, sourceFilePath, "## Do not edit between this and DO NOT REMOVE", "## DO NOT REMOVE: Personal setting go under this line")
    }
    log.Info().Msg("rootfiles successfully updated.")

    agePubKey, err := GetPubKey()
    if err != nil {
        log.Fatal().Err(err).Msg("error: %v")
    }

    helper.ReplaceInFile(".sops.yaml", "REPLACEME", agePubKey)
    if err != nil {
        log.Fatal().Err(err).Msg("Error: %s")
    }

    CheckEnvVariables()

    return nil

}

// Function to read all filenames in a directory
func readFilenamesInDir(dir string) ([]string, error) {
    files, err := ioutil.ReadDir(dir)
    if err != nil {
        return nil, err
    }

    var filenames []string
    for _, file := range files {
        if !file.IsDir() {
            filenames = append(filenames, file.Name())
        }
    }
    return filenames, nil
}

func ResetBootstrapValues() error {
    LoadTalEnv(false)
    err := helper.CopyDirFiltered(helper.KubeCache, helper.ClusterPath+"/kubernetes", true, `^bootstrap-values\.yaml.ct$`)
    if err != nil {
        log.Info().Msg("Error:")
    }

    err2 := helper.EnvSubstRecursive(helper.ClusterPath+"/kubernetes", `^bootstrap-values\.yaml.ct$`, helper.TalEnv)
    if err2 != nil {
        log.Info().Msg("Error:")
    }

    log.Info().Msg("Bootstrap-Values.yaml Files reset successfully.")
    return nil
}

func GenPatches() error {

    err := helper.CopyDir(helper.PatchCache, path.Join(helper.ClusterPath, "/talos/patches"), true)
    if err != nil {
        log.Info().Msg("Error:")
    } else {
        log.Info().Msg("Patch files copied successfully.")
    }

    ageSecKey, err := GetSecKey()
    helper.ReplaceInFile(filepath.Join(helper.ClusterPath+"/talos/patches", "sopssecret.yaml"), "REPLACEWITHSOPS", ageSecKey)
    if err != nil {
        log.Fatal().Err(err).Msg("Error: %s")
    }

    setDocker()

    return nil
}

func setDocker() {
    // Assuming this is part of your function
    if helper.TalEnv["DOCKERHUB_USER"] != "" && helper.TalEnv["DOCKERHUB_PASSWORD"] != "" {
        // Prepare the content to append
        configContent := fmt.Sprintf(`# Add Dockerhub Login
- op: add
  path: /machine/registries/config
  value:
    registry-1.docker.io:
      auth:
        username: "%s"
        password: "%s"
    docker.io:
      auth:
        username: "%s"
        password: "%s"
    `, helper.TalEnv["DOCKERHUB_USER"], helper.TalEnv["DOCKERHUB_PASSWORD"], helper.TalEnv["DOCKERHUB_USER"], helper.TalEnv["DOCKERHUB_PASSWORD"])

        // Open the file in append mode or create it if it doesn't exist
        file, err := os.OpenFile(filepath.Join(helper.ClusterPath+"/talos/patches", "all.yaml"), os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
        if err != nil {
            log.Fatal().Err(err).Msg("Error opening file: %s")
        }
        defer file.Close()

        // Write the content to the file
        if _, err := file.Write([]byte(configContent)); err != nil {
            log.Fatal().Err(err).Msg("Error writing to file: %s")
        }
    } else {
        // Optional: Append a note if the environment variables are not set
        emptyContent := `# No DockerHub credentials provided
    `
        file, err := os.OpenFile(filepath.Join(helper.ClusterPath+"/talos/patches", "all.yaml"), os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
        if err != nil {
            log.Fatal().Err(err).Msg("Error opening file: %s")
        }
        defer file.Close()

        if _, err := file.Write([]byte(emptyContent)); err != nil {
            log.Fatal().Err(err).Msg("Error writing to file: %s")
        }
    }
}

func ageGen() error {
    outFlag := "age.agekey"

    if _, err := os.Stat(outFlag); err == nil {

    } else if errors.Is(err, os.ErrNotExist) {
        out := os.Stdout
        f, err := os.OpenFile(outFlag, os.O_WRONLY|os.O_CREATE|os.O_EXCL, 0600)
        if err != nil {
            log.Fatal().Err(err).Msg("failed to open output file %q: %v")
        }
        defer func() {
            if err := f.Close(); err != nil {
                log.Fatal().Err(err).Msg("failed to close output file %q: %v")
            }
        }()
        out = f
        if fi, err := out.Stat(); err == nil && fi.Mode().IsRegular() && fi.Mode().Perm()&0004 != 0 {
            log.Info().Msgf("writing secret key to a world-readable file\n")
        }

        k, err := age.GenerateX25519Identity()
        if err != nil {
            log.Fatal().Err(err).Msg("internal error: %v")
        }

        fmt.Fprintf(out, "# created: %s\n", time.Now().Format(time.RFC3339))
        fmt.Fprintf(out, "# public key: %s\n", k.Recipient())
        fmt.Fprintf(out, "%s\n", k)

    } else {

    }

    return nil
}

func GetPubKey() (string, error) {
    // Open the file
    filename := "age.agekey"
    file, err := os.Open(filename)
    if err != nil {
        return "", fmt.Errorf("failed to open file: %v", err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    var publicKey string

    // Read the file line by line
    for scanner.Scan() {
        line := scanner.Text()
        // Find the line with the public key
        if strings.HasPrefix(line, "# public key:") {
            parts := strings.Split(line, ": ")
            if len(parts) == 2 {
                publicKey = parts[1]
            }
            break
        }
    }

    if err := scanner.Err(); err != nil {
        return "", fmt.Errorf("failed to scan file: %v", err)
    }

    if publicKey == "" {
        return "", fmt.Errorf("public key not found")
    }

    return publicKey, nil
}

// getSecretKeyFromFile reads the specified file and returns the secret key found within it.
func GetSecKey() (string, error) {
    // Open the file
    filename := "age.agekey"
    file, err := os.Open(filename)
    if err != nil {
        return "", fmt.Errorf("failed to open file: %v", err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    var secretKey string

    // Read the file line by line
    for scanner.Scan() {
        line := scanner.Text()
        // Find the line that contains the secret key prefix
        if strings.HasPrefix(line, "AGE-SECRET-KEY-") {
            secretKey = line
            break
        }
    }

    if err := scanner.Err(); err != nil {
        return "", fmt.Errorf("failed to scan file: %v", err)
    }

    if secretKey == "" {
        return "", fmt.Errorf("secret key not found")
    }

    return secretKey, nil
}

func GenSopsSecret() error {
    secretPath := filepath.Join(helper.ClusterPath, "kubernetes", "flux-system", "flux", "sopssecret.secret.yaml")
    ageSecKey, err := GetSecKey()
    // Generate Kubernetes secret YAML content
    secret := map[string]interface{}{
        "apiVersion": "v1",
        "kind":       "Secret",
        "metadata": map[string]interface{}{
            "name":      "sops-age",
            "namespace": "flux-system",
        },
        "stringData": map[string]interface{}{
            "age.agekey": ageSecKey,
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
    log.Info().Msgf("SOPS secret YAML saved to: %s\n", secretPath)
    return nil
}
