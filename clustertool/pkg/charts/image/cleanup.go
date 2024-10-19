package image

import (
    "fmt"
    "regexp"
    "strings"

    "github.com/rs/zerolog/log"

    "k8s.io/apimachinery/pkg/util/validation"
)

var (
    // Valid SemVer format (Major.Minor.Patch)
    semVerPattern = regexp.MustCompile(`^(\d+)\.(\d+)\.(\d+)$`)
    // Matches tags like "RELEASE.2023-11-20T22-40-07Z"
    releasePattern = regexp.MustCompile(`^RELEASE\.[0-9]{4}-[0-9]{2}-[0-9]{2}T`)
    // Matches tags like "x64-1.2.3" and "arm64-1.2.3" followed by a numeric version
    archPattern = regexp.MustCompile(`^[a-zA-Z0-9]+-[0-9]+\.[0-9]+`)
    // Matches tags like "latest-2023-12-18"
    prefixYearMonthDayPattern = regexp.MustCompile(`^[a-zA-Z0-9]+-[0-9]{4}-[0-9]{2}-[0-9]{2}$`)
    // Matches dates like "2023-11-15" and "2022-04"
    yearMonthDayPattern = regexp.MustCompile(`^[0-9]{4}-[0-9]{2}(-[0-9]{2})?$`)
    // Matches tags like "1.2.3.4" "1.2" and "1"
    incompleteSemVerPattern = regexp.MustCompile(`^[0-9]+(\.[0-9]+)*$`)
    // Matches tags like "something-abcdefg" (only chars before dash and exactly 7 characters after the dash)
    shortCommitHashSuffixPattern = regexp.MustCompile(`^[a-zA-Z]+-[a-zA-Z0-9]{7}$`)
    // Matches tags like "v1.2.3", "V1.2.3, #1.2.3, $1.2.3, etc"
    leadingSymbolPattern = regexp.MustCompile(`^version|Version|[vV]|^[^a-zA-Z0-9]+`)
)

func CleanTag(tag string) (string, error) {
    tag = strings.TrimSpace(tag)

    if tag == "" {
        return "", fmt.Errorf("tag is empty")
    }

    // Do basic cleaning
    tag = cleanSha(tag)
    tag = cleanLeadingSymbol(tag)

    // Return early if the tag is already in SemVer format
    if semVerPattern.MatchString(tag) {
        return tag, nil
    }

    switch {
    case releasePattern.MatchString(tag):
        tag = cleanRelease(tag)
    case archPattern.MatchString(tag):
        tag = cleanArch(tag)
    case prefixYearMonthDayPattern.MatchString(tag):
        tag = cleanPrefixYearMonthDay(tag)
    case yearMonthDayPattern.MatchString(tag):
        tag = cleanYearMonthDay(tag)
    case incompleteSemVerPattern.MatchString(tag):
        tag = cleanIncompleteSemVer(tag)
    case shortCommitHashSuffixPattern.MatchString(tag):
        tag = keepShortCommitHashSuffix(tag)
    case leadingSymbolPattern.MatchString(tag):
        tag = cleanLeadingSymbol(tag)
    }

    // If string contains `-` the second part is usually
    // either a commit hash or things like "debian" or "alpine"
    // Make sure the first part is some kind of versioning and strip the rest
    if strings.Contains(tag, "-") {
        split := strings.Split(tag, "-")
        switch {
        case semVerPattern.MatchString(split[0]):
            tag = split[0]
        case incompleteSemVerPattern.MatchString(split[0]):
            tag = split[0]
        }
    }

    // Re-check for incomplete SemVer after cleaning
    if incompleteSemVerPattern.MatchString(tag) {
        tag = cleanIncompleteSemVer(tag)
    }

    if err := checkValidLabelValue(tag); err != nil {
        return "", err
    }

    if !semVerPattern.MatchString(tag) {
        log.Warn().Msgf("Could not produce a valid SemVer tag for tag [%s]", tag)
    }

    // Build and return the updated SemVer string
    return tag, nil
}

func Clean(tag string) error {

    newTag, err := CleanTag(tag)
    if err != nil {
        log.Fatal().Err(err).Msgf("Failed to clean tag [%s]", tag)
    }

    log.Info().Msgf("Tag [%s] cleaned to [%s]", tag, newTag)
    return nil
}

func checkValidLabelValue(tag string) error {
    if errs := validation.IsValidLabelValue(tag); len(errs) > 0 {
        return fmt.Errorf("tag [%s] is not valid for label use. error: %s", tag, (strings.Join(errs, ", ")))
    }
    return nil
}

// keepShortCommitHashSuffix keeps the last 7 characters of a tag
// eg "something-abcdefg" -> "abcdefg"
func keepShortCommitHashSuffix(tag string) string {
    return strings.Split(tag, "-")[1]
}

// cleanRelease Transforms release pattern format
// eg "RELEASE.2023-11-20T22-40-07Z" -> "2023.11.20"
func cleanRelease(tag string) string {
    tag = strings.Split(tag, ".")[1]
    tag = strings.Split(tag, "T")[0]
    tag = strings.ReplaceAll(tag, "-", ".")

    return tag
}

// cleanArch removes arch prefixes
// eg "x64-1.2.3" -> "1.2.3"
func cleanArch(tag string) string {
    tag = strings.Split(tag, "-")[1]

    return tag
}

// cleanYearMonthDay Transforms date versions
// eg "2023-11-15" -> "2023.11.15" and "2022-04" -> "2022.4"
func cleanYearMonthDay(tag string) string {
    tag = strings.ReplaceAll(tag, "-", ".")
    parts := strings.Split(tag, ".")
    for idx := range parts {
        parts[idx] = strings.TrimPrefix(parts[idx], "0")
    }
    for len(parts) < 3 {
        parts = append(parts, "0")
    }
    tag = strings.Join(parts, ".")

    return tag
}

// cleanIncompleteSemVer Transforms incomplete SemVer strings
// eg "1.2" -> "1.2.0" and "1" -> "1.0.0"
// versions with more parts are left as-is
func cleanIncompleteSemVer(tag string) string {
    parts := strings.Split(tag, ".")
    switch {
    case len(parts) == 2:
        tag = tag + ".0"
    case len(parts) == 1:
        tag = tag + ".0.0"
    }

    return tag
}

// cleanLeadingSymbol Trims leading 'v' or non-alphanumeric characters
// e.g "v1.2.3" -> "1.2.3"
func cleanLeadingSymbol(tag string) string {
    return leadingSymbolPattern.ReplaceAllString(tag, "")
}

// cleanSha Strips everything after '@'
// e.g "v1.2.3@sha256:abc123" -> "v1.2.3"
func cleanSha(tag string) string {
    return strings.Split(tag, "@")[0]
}

// cleanPrefixYearMonthDay Transforms date versions with prefix
// eg "latest-2023-12-18" -> "2023.12.18"
func cleanPrefixYearMonthDay(tag string) string {
    calVer := strings.Split(tag, "-")[1:]
    tag = strings.Join(calVer, ".")

    return tag
}
