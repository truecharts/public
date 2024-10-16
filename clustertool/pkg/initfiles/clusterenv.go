package initfiles

import (
	"fmt"
	"net"
	"os"
	"strings"

	"github.com/rs/zerolog/log"
	"github.com/truecharts/private/clustertool/pkg/helper"
)

func LoadTalEnv() error {
	// Check if talenv.yaml file exists
	if _, err := os.Stat(helper.ClusterPath + "/clusterenv.yaml"); err == nil {
		// Load environment variables from clusterenv.yaml
		err := helper.LoadEnvFromFile(helper.ClusterPath+"/clusterenv.yaml", helper.TalEnv)
		if err != nil {
			log.Info().Msgf("Error loading environment from clusterenv.yaml: %v\n", err)
			os.Exit(1)
		}
	} else if os.IsNotExist(err) {
		log.Info().Msg("clusterenv.yaml file not found, skipping environment variable loading.")
	} else {
		log.Info().Msgf("Error checking clusterenv.yaml file: %v\n", err)
		os.Exit(1)
	}
	clusterName()
	PostProcessTalEnv()
	clusterEnvtoEnv()
	log.Info().Msgf("ClusterEnv loaded successfully\n", )
	return nil
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
	LoadTalEnv()
	requiredKeys := []string{
		"VIP",
		"MASTER1IP_IP",
		"MASTER1IP_NETMASK",
		"GATEWAY",
		"METALLB_RANGE",
		"DASHBOARD_IP_IP",
		"PODNET",
		"SVCNET",
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
	inRange, err = helper.IPInRange(helper.TalEnv["DASHBOARD_IP"], helper.TalEnv["METALLB_RANGE"])
	if err != nil {
		log.Info().Msgf("Error checking DASHBOARD_IP against METALLB_RANGE: %v\n", err)
		os.Exit(1)
	}
	if !inRange {
		log.Info().Msg("Cannot proceed, DASHBOARD_IP must be in the METALLB_RANGE")
		os.Exit(1)
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
