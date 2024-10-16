package initfiles

import (
	"bufio"
	"encoding/json"
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

	age "filippo.io/age"
	talhelperCfg "github.com/budimanjojo/talhelper/v3/pkg/config"
	"github.com/invopop/jsonschema"
	"github.com/truecharts/private/clustertool/pkg/fluxhandler"
	"github.com/truecharts/private/clustertool/pkg/helper"
)

func InitFiles() error {
	ageGen()
	genRootFiles()
	genBaseFiles()
	UpdateRootFiles()
	UpdateBaseFiles()
	GenSchema()
	GenPatches()
	genKubernetes()
	GenTalEnvConfigMap()
	UpdateGitRepo()
	fluxhandler.CreateGitSecret(helper.TalEnv["GITHUB_REPOSITORY"])
	fluxhandler.CreateSshPatch()
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
	log.Info().Msgf("test %v", clusterSettingsDest)
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
	// If the input starts with "https://", remove it
	if strings.HasPrefix(input, "https://") {
		input = strings.TrimPrefix(input, "https://")
	}

	// If the input does not start with "ssh://", add "ssh://"
	if !strings.HasPrefix(input, "ssh://") {
		input = "ssh://" + input
	}

	// Replace "github.com/" with "git@github.com:" if present
	input = strings.Replace(input, "github.com/", "git@github.com:", 1)

	// Compile a regex to match and replace the URL pattern
	re := regexp.MustCompile(`^ssh://git@github.com:(\w+)/(\w+).git$`)
	matches := re.FindStringSubmatch(input)

	if len(matches) == 3 {
		// Reformat the URL
		return fmt.Sprintf("ssh://git@github.com/%s/%s.git", matches[1], matches[2])
	}

	// Return the input if it doesn't match the expected pattern
	return input
}

func genBaseFiles() error {
	err := helper.CopyDir(helper.BaseCache, helper.ClusterPath+"", false)
	if err != nil {
		log.Info().Msgf("Error: %v", err)
	} else {
		log.Info().Msg("Base files copied successfully.")
	}

	log.Info().Msg("basefiles successfully altered.")
	return nil
}

func UpdateBaseFiles() error {
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
	LoadTalEnv()
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

	// Read the content of the talenv.yaml file
	talenvContent, err := os.ReadFile(helper.ClusterPath + "/clusterenv.yaml")
	if err != nil {
		return err
	}

	// Convert the file content to a string and split it into lines
	talenvLines := strings.Split(string(talenvContent), "\n")

	// Add indentation to each line
	for i, line := range talenvLines {
		talenvLines[i] = "          " + line
	}

	// Join the indented lines back into a single string
	indentedTalenvContent := strings.Join(talenvLines, "\n")

	helper.ReplaceInFile(filepath.Join(helper.ClusterPath, "/talos/patches", "sopssecret.yaml"), "REPLACEWITHTALENV", indentedTalenvContent)
	// log.Info().Msg("test", filepath.Join(helper.ClusterPath, "/talos/patches", "sopssecret.yaml"))
	if err != nil {
		log.Fatal().Err(err).Msg("Error: %s")
	}

	return nil
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

func GenSchema() error {
	cfg := talhelperCfg.TalhelperConfig{}
	r := new(jsonschema.Reflector)
	r.FieldNameTag = "yaml"
	r.RequiredFromJSONSchemaTags = true
	os.MkdirAll(helper.ClusterPath+"/talos", os.ModePerm)
	var genschemaFile = path.Join(helper.ClusterPath, "/talos/talconfig.json")

	schema := r.Reflect(&cfg)
	data, _ := json.MarshalIndent(schema, "", "  ")
	if err := os.WriteFile(genschemaFile, data, os.FileMode(0o644)); err != nil {
		log.Fatal().Err(err).Msg("failed to write file to %s: %v")
	}
	return nil
}
