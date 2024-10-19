package helper

import (
    "net"
    "os"
    "strings"

    "github.com/rs/zerolog/log"
)

// CIDROverlap checks if two CIDR annotations overlap.
func CIDROverlap(cidr1, cidr2 string) (bool, error) {
    _, ipnet1, err1 := net.ParseCIDR(cidr1)
    _, ipnet2, err2 := net.ParseCIDR(cidr2)

    if err1 != nil || err2 != nil {
        return false, err1
    }

    return ipnet1.Contains(ipnet2.IP) || ipnet2.Contains(ipnet1.IP), nil
}

// IPInCIDR checks if an IP fits into a CIDR.
func IPInCIDR(ipStr, cidr string) (bool, error) {
    ip := net.ParseIP(ipStr)
    if ip == nil {
        return false, nil
    }

    _, ipnet, err := net.ParseCIDR(cidr)
    if err != nil {
        return false, err
    }

    return ipnet.Contains(ip), nil
}

// IPInRange checks if an IP fits into an IP range (ip-ip).
func IPInRange(ipStr, rangeStr string) (bool, error) {
    ip := net.ParseIP(ipStr)
    if ip == nil {
        return false, nil
    }

    parts := strings.Split(rangeStr, "-")
    if len(parts) != 2 {
        return false, nil
    }

    startIP := net.ParseIP(parts[0])
    endIP := net.ParseIP(parts[1])
    if startIP == nil || endIP == nil {
        return false, nil
    }

    return bytesCompare(ip, startIP) >= 0 && bytesCompare(ip, endIP) <= 0, nil
}

// bytesCompare compares two IP addresses.
// Returns -1 if a < b, 0 if a == b, 1 if a > b.
func bytesCompare(a, b net.IP) int {
    for i := range a {
        if a[i] < b[i] {
            return -1
        }
        if a[i] > b[i] {
            return 1
        }
    }
    return 0
}

func ValidateIPorCIDRNotInCIDR(ipOrCIDR, cidr, ipOrCIDRName, cidrName string) {
    inCIDR, err := IPInCIDR(ipOrCIDR, cidr)
    if err != nil {
        log.Info().Msgf("Error validating %s against %s: %v\n", ipOrCIDRName, cidrName, err)
        os.Exit(1)
    }
    if inCIDR {
        log.Info().Msgf("Cannot proceed, %s cannot be in %s\n", ipOrCIDRName, cidrName)
        os.Exit(1)
    }
}

func ValidateRangeNotInCIDR(rangeStr, cidr, rangeName, cidrName string) {
    parts := strings.Split(rangeStr, "-")
    if len(parts) != 2 {
        log.Info().Msgf("Invalid range format for %s\n", rangeName)
        os.Exit(1)
    }

    inCIDRStart, errStart := IPInCIDR(parts[0], cidr)
    inCIDREnd, errEnd := IPInCIDR(parts[1], cidr)

    if errStart != nil || errEnd != nil {
        log.Info().Msgf("Error validating %s against %s: %v %v\n", rangeName, cidrName, errStart, errEnd)
        os.Exit(1)
    }

    if inCIDRStart || inCIDREnd {
        log.Info().Msgf("Cannot proceed, %s cannot be in %s\n", rangeName, cidrName)
        os.Exit(1)
    }
}
