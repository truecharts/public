package initfiles

import (
    "bufio"
    "fmt"
    "net"
    "os"
    "regexp"
    "strings"
    "unicode"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func LoadTalEnv(noFail bool) error {
    // Check if clusterenv.yaml file exists
    if _, err := os.Stat(helper.ClusterPath + "/clusterenv.yaml"); err == nil {
        // Load environment variables from clusterenv.yaml
        err := helper.LoadEnvFromFile(helper.ClusterPath+"/clusterenv.yaml", helper.TalEnv)
        if err != nil {
            log.Info().Msgf("Error loading environment from clusterenv.yaml: %v\n", err)
            os.Exit(1)
        }
    } else if os.IsNotExist(err) {
        // If the file doesn't exist, check noFail to determine next steps
        if noFail {
            log.Debug().Msg("clusterenv.yaml file not found, but skipping due to noFail being true.")
            return nil // Skip execution without error
        } else {
            log.Fatal().Msg("clusterenv.yaml file not found, exiting...")
            os.Exit(1) // Exit with error code 1
        }
    } else {
        log.Info().Msgf("Error checking clusterenv.yaml file: %v\n", err)
        os.Exit(1)
    }

    // If file exists, continue with processing
    clusterName()
    checkQuotedNumbersInFile()
    PostProcessTalEnv()
    clusterEnvtoEnv()
    log.Info().Msgf("ClusterEnv loaded successfully\n")
    return nil
}

// Function to check if all numbers after ':' in a file are unquoted integers or floats
func checkQuotedNumbersInFile() (bool, error) {

    filePath := helper.ClusterPath + "/clusterenv.yaml"
    // Regular expression to find patterns like ': number' where number can be an int or float
    re := regexp.MustCompile(`:\s*(.+)`) // Matches anything after ': '

    // Open the file
    file, err := os.Open(filePath)
    if err != nil {
        log.Error().Msgf("Failed to open file: %s \nError: %s", filePath, err)
        os.Exit(1)
        return false, err
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    for scanner.Scan() {
        line := scanner.Text()

        // Skip lines that start with a number
        trimmedLine := strings.TrimSpace(line)
        if len(trimmedLine) > 0 && unicode.IsDigit(rune(trimmedLine[0])) {
            continue
        }

        // Find matches for entries in each line
        matches := re.FindStringSubmatch(line)
        if len(matches) < 2 {
            continue // Skip lines without a colon and value
        }

        // Get the value after the colon
        value := strings.TrimSpace(matches[1])

        // Check if the value is a valid number (int or float with a single dot)
        isValidNumber := regexp.MustCompile(`^[0-9]+(\.[0-9]+)?$`).MatchString(value)

        // If it's a valid number, log an error
        if isValidNumber {
            log.Error().Msgf("Unquoted number found %s line: %s", filePath, line)
            os.Exit(1)
            return false, nil
        }
    }

    if err := scanner.Err(); err != nil {
        log.Error().Msgf("Error scanning the file: %s", err)
        os.Exit(1)
        return false, err
    }

    return true, nil
}

func clusterName() {
    helper.TalEnv["CLUSTERNAME"] = helper.ClusterName
}

func clusterEnvtoEnv() {
    // Split IP/NETMASK and normalize IPs
    for key, value := range helper.TalEnv {
        os.Setenv(key, value)
    }
}
func PostProcessTalEnv() {
    // Split IP/NETMASK and normalize IPs
    for key, value := range helper.TalEnv {
        ip, netmask, err := splitIPandNetmask(value)
        if err == nil {
            // Update TalEnv with IP and NETMASK entries
            helper.TalEnv[key+"_IP"] = ip
            helper.TalEnv[key+"_NETMASK"] = netmask
            helper.TalEnv[key+"_CIDR"] = ip + "/" + netmask
        }
    }

    // Validate and normalize specific IP variables
    ValidateAndNormalizeIPsInTalEnv()

    // Validate and normalize IP/NETMASK variables
    ValidateAndNormalizeIPNetmaskVarsInTalEnv()
}

func splitIPandNetmask(ipWithMask string) (string, string, error) {
    // Check if IP/NETMASK format
    parts := strings.Split(ipWithMask, "/")
    if len(parts) == 2 {
        ip := parts[0]
        netmask := parts[1]
        // Validate netmask format (you might want to add more rigorous validation)
        if _, _, err := net.ParseCIDR(ipWithMask); err != nil {
            return "", "", fmt.Errorf("invalid IP/NETMASK format: %s", ipWithMask)
        }
        return ip, netmask, nil
    }

    // Assume NETMASK 24 if only IP provided
    ip := ipWithMask
    netmask := "24"
    // Validate IP format (you might want to add more rigorous validation)
    if net.ParseIP(ip) == nil {
        return "", "", fmt.Errorf("invalid IP format: %s", ipWithMask)
    }
    return ip, netmask, nil
}

func ValidateAndNormalizeIPsInTalEnv() {
    ipVariables := []string{"Master1IP"}

    for _, key := range ipVariables {
        value, exists := helper.TalEnv[key]
        if !exists {
            continue // Skip if the variable doesn't exist in TalEnv
        }

        ip, err := normalizeIP(value)
        if err != nil {
            log.Info().Msgf("Error processing %s: %v\n", key, err)
            continue
        }

        // Update TalEnv with normalized IP value
        helper.TalEnv[key] = ip
    }
}

func normalizeIP(ipWithMask string) (string, error) {
    // Check if IP/NETMASK format
    parts := strings.Split(ipWithMask, "/")
    if len(parts) == 2 {
        ip := parts[0]
        netmask := parts[1]
        // Validate netmask format (you might want to add more rigorous validation)
        if _, _, err := net.ParseCIDR(ipWithMask); err != nil {
            return "", fmt.Errorf("invalid IP/NETMASK format: %s", ipWithMask)
        }
        return ip + "/" + netmask, nil
    }

    // Assume NETMASK 24 if only IP provided
    ip := ipWithMask
    // Validate IP format (you might want to add more rigorous validation)
    if net.ParseIP(ip) == nil {
        return "", fmt.Errorf("invalid IP format: %s", ipWithMask)
    }
    return ip + "/24", nil // Default to /24 subnet mask
}

func ValidateAndNormalizeIPNetmaskVarsInTalEnv() {
    netmaskVariables := []string{"PODNET", "SVCNET"}

    for _, key := range netmaskVariables {
        value, exists := helper.TalEnv[key]
        if !exists {
            continue // Skip if the variable doesn't exist in TalEnv
        }

        ipNetmask, err := normalizeIPNetmask(value)
        if err != nil {
            log.Info().Msgf("Error processing %s: %v\n", key, err)
            continue
        }

        // Update TalEnv with normalized IP/NETMASK value
        helper.TalEnv[key] = ipNetmask
    }
}

func normalizeIPNetmask(ipNetmask string) (string, error) {
    // Validate IP/NETMASK format
    if _, _, err := net.ParseCIDR(ipNetmask); err != nil {
        return "", fmt.Errorf("invalid IP/NETMASK format: %s", ipNetmask)
    }
    return ipNetmask, nil
}

func CheckEnvVariables() {
    LoadTalEnv(false)
    requiredKeys := []string{
        "VIP",
        "MASTER1IP_IP",
        "MASTER1IP_NETMASK",
        "DASHBOARD_IP",
        "GATEWAY",
        "METALLB_RANGE",
        "PODNET",
        "SVCNET",
        "DOMAIN_0",
        "DOMAIN_0_EMAIL",
        "DOMAIN_0_CLOUDFLARE_TOKEN",
    }
    for _, key := range requiredKeys {
        if helper.TalEnv[key] == "" {
            log.Info().Msgf("%s cannot be empty\n", key)
            os.Exit(1)
        }
    }

    // Validate VIP and MASTER1IP format and check subnet compatibility
    vip := helper.TalEnv["VIP_IP"]
    master1ip := helper.TalEnv["MASTER1IP_IP"]
    master1ipCidr := helper.TalEnv["MASTER1IP_CIDR"]
    gateway := helper.TalEnv["GATEWAY"]

    // Check if MASTER1IP matches GATEWAY or VIP
    if master1ip == gateway || master1ip == vip {
        log.Info().Msg("Cannot proceed, MASTER1IP cannot match GATEWAY or VIP")
        os.Exit(1)
    }

    // Check if VIP matches any Node IPs
    if vip == master1ip {
        log.Info().Msg("Cannot proceed, VIP cannot match any Node IPs")
        os.Exit(1)
    }

    // Check ranges against METALLB_RANGE
    inRange, err := helper.IPInRange(vip, helper.TalEnv["METALLB_RANGE"])
    if err != nil {
        log.Info().Msgf("Error checking VIP against METALLB_RANGE: %v\n", err)
        os.Exit(1)
    }
    if inRange {
        log.Info().Msg("Cannot proceed, VIP cannot be in the METALLB_RANGE")
        os.Exit(1)
    }

    inRange, err = helper.IPInRange(master1ip, helper.TalEnv["METALLB_RANGE"])
    if err != nil {
        log.Info().Msgf("Error checking MASTER1IP against METALLB_RANGE: %v\n", err)
        os.Exit(1)
    }
    if inRange {
        log.Info().Msg("Cannot proceed, MASTER1IP cannot be in the METALLB_RANGE")
        os.Exit(1)
    }

    inRange, err = helper.IPInRange(gateway, helper.TalEnv["METALLB_RANGE"])
    if err != nil {
        log.Info().Msgf("Error checking GATEWAY against METALLB_RANGE: %v\n", err)
        os.Exit(1)
    }
    if inRange {
        log.Info().Msg("Cannot proceed, GATEWAY cannot be in the METALLB_RANGE")
        os.Exit(1)
    }

    // Check DASHBOARD_IP against METALLB_RANGE
    if helper.TalEnv["DASHBOARD_IP"] != "" {
        inRange, err = helper.IPInRange(helper.TalEnv["DASHBOARD_IP"], helper.TalEnv["METALLB_RANGE"])
        if err != nil {
            log.Info().Msgf("Error checking DASHBOARD_IP against METALLB_RANGE: %v\n", err)
            os.Exit(1)
        }
        if !inRange {
            log.Info().Msg("Cannot proceed, DASHBOARD_IP must be in the METALLB_RANGE")
            os.Exit(1)
        }
    }

    // Validate other CIDR/IP checks with new netmask support
    helper.ValidateIPorCIDRNotInCIDR(vip+"/32", helper.TalEnv["PODNET"], "VIP", "PODNET")
    helper.ValidateIPorCIDRNotInCIDR(master1ipCidr, helper.TalEnv["PODNET"], "MASTER1IP", "PODNET")
    helper.ValidateIPorCIDRNotInCIDR(gateway+"/32", helper.TalEnv["PODNET"], "GATEWAY", "PODNET")
    helper.ValidateRangeNotInCIDR(helper.TalEnv["METALLB_RANGE"], helper.TalEnv["PODNET"], "METALLB_RANGE", "PODNET")

    helper.ValidateIPorCIDRNotInCIDR(vip+"/32", helper.TalEnv["SVCNET"], "VIP", "SVCNET")
    helper.ValidateIPorCIDRNotInCIDR(master1ipCidr, helper.TalEnv["SVCNET"], "MASTER1IP", "SVCNET")
    helper.ValidateIPorCIDRNotInCIDR(gateway+"/32", helper.TalEnv["SVCNET"], "GATEWAY", "SVCNET")
    helper.ValidateRangeNotInCIDR(helper.TalEnv["METALLB_RANGE"], helper.TalEnv["SVCNET"], "METALLB_RANGE", "SVCNET")
}
