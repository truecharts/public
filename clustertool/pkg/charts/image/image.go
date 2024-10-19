package image

import (
    "fmt"
    "regexp"
    "strings"

    "github.com/knadh/koanf/parsers/yaml"
    "github.com/knadh/koanf/providers/file"
    "github.com/knadh/koanf/v2"
    "github.com/rs/zerolog/log"
)

// Images represents the structure of values.yaml.
type Images struct {
    ImagesMap map[string]ImageDetails
    K         *koanf.Koanf
}

// ImageDetails represents details for each image.
type ImageDetails struct {
    Repository string `yaml:"repository"`
    Tag        string `yaml:"tag"`
    Version    string
    Link       string
    // Add other fields as needed
}

var imageRegex = regexp.MustCompile(`^image|[a-zA-Z0-9]+Image$`)

func (i *Images) LoadValuesFile(filename string) error {
    // Initialize koanf instance
    i.K = koanf.New(".")

    // Load YAML file using koanf
    if err := i.K.Load(file.Provider(filename), yaml.Parser()); err != nil {
        return err
    }

    // List only root-level keys that match the criteria
    keys := getFilteredRootLevelKeys(i.K)
    i.ImagesMap = make(map[string]ImageDetails)
    for _, key := range keys {
        // Extract relevant fields from the loaded configuration
        var img ImageDetails
        if err := i.K.Unmarshal(key, &img); err != nil {
            return err
        }

        // Set the Link field based on the repository
        img.Link = constructLink(img.Repository)

        // Set the Version field based on the tag
        version, err := CleanTag(img.Tag)
        if err != nil {
            log.Error().Err(err).Msg("❌ Failed to clean tag")
        }

        img.Version = version

        // Save the extracted values to the struct
        i.ImagesMap[key] = img
    }

    return nil
}

func getFilteredRootLevelKeys(k *koanf.Koanf) []string {
    filteredKeys := []string{}

    // k.Raw() returns a map[string]interface{} with all the keys and their values
    // This means the keys will only be the root-level keys, we can drill into the
    // values later if we want the nested keys.
    for key := range k.Raw() {
        if key == "imageSelector" {
            log.Error().Msg("❌ Found [imageSelector] in top level keys, this is not supported.")
            continue
        }
        // Filter keys that match the regex
        if imageRegex.MatchString(key) {
            filteredKeys = append(filteredKeys, key)
        }
    }

    return filteredKeys
}

// constructLink constructs a link based on the repository using the logic from the main function.
func constructLink(repository string) string {
    prefix := ""

    switch {
    case strings.HasPrefix(repository, "lscr.io/linuxserver/"):
        prefix = "https://fleet.linuxserver.io/image?name="
        repository = strings.TrimPrefix(repository, "lscr.io/")
    case strings.HasPrefix(repository, "tccr.io/tccr/"):
        prefix = "https://github.com/truecharts/containers/tree/master/apps/"
        repository = strings.TrimPrefix(repository, "tccr.io/tccr/")
    case strings.HasPrefix(repository, "mcr.microsoft.com/"):
        prefix = "https://mcr.microsoft.com/en-us/product/"
        repository = strings.TrimPrefix(repository, "mcr.microsoft.com/")
    case strings.HasPrefix(repository, "public.ecr.aws/"):
        prefix = "https://gallery.ecr.aws/"
        repository = strings.TrimPrefix(repository, "public.ecr.aws/")
    case strings.HasPrefix(repository, "ghcr.io/"):
        prefix = "https://"
    case strings.HasPrefix(repository, "quay.io/"):
        prefix = "https://"
    case strings.HasPrefix(repository, "gcr.io/"):
        prefix = "https://"
    case strings.Contains(repository, ".azurecr.io/"):
        reg := fmt.Sprintf(`%s.azurecr.io/`, strings.Split(repository, ".")[0])
        prefix = fmt.Sprintf("https://%s", reg)
        repository = strings.TrimPrefix(repository, reg)
    case strings.Contains(repository, ".ocir.io/"):
        prefix = ""
    default:
        // Docker Hub or unknown registry
        prefix = "https://hub.docker.com/r/"
        repository = strings.TrimPrefix(repository, "docker.io/")
        repository = strings.TrimPrefix(repository, "index.docker.io/")
        repository = strings.TrimPrefix(repository, "registry-1.docker.io/")
        repository = strings.TrimPrefix(repository, "registry.hub.docker.com/")

        // Check for Docker Official Image
        if strings.Count(repository, "/") == 0 || strings.HasPrefix(repository, "library/") {
            prefix = "https://hub.docker.com/_/"
            repository = strings.TrimPrefix(repository, "library/")
        }

        // Avoid creating a bad link if the image name has more than 1 slash
        slashes := strings.Count(repository, "/")
        if slashes > 1 {
            prefix = ""
            log.Warn().Msgf("WARNING: Could not determine source repository url for [%s]", repository)
        }
    }

    if prefix == "" {
        log.Warn().Msgf("WARNING: Could not determine source repository url for [%s]", repository)
        return ""
    }

    containerURL := fmt.Sprintf("%s%s", prefix, repository)
    return containerURL
}
