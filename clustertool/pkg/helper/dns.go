package helper

import (
    "net"
    "os"

    "github.com/rs/zerolog/log"
)

func checkDNSResolution(domain string) bool {
    _, err := net.LookupHost(domain)
    if err != nil {
        return false
    }
    return true
}

func checkAllDomains(domains []string, verbose bool) {
    for _, domain := range domains {
        if !checkDNSResolution(domain) {
            log.Info().Msgf("DNS for %s does not resolve.\n", domain)
            os.Exit(1)
        } else {
            if verbose {
                log.Info().Msgf("DNS for %s resolves.\n", domain)
            }
        }
    }
}

func CheckReqDomains() {
    domains := []string{
        "tccr.io",
        "ghcr.io",
        "github.com",
        "docker.com",
    }

    checkAllDomains(domains, false)
}
