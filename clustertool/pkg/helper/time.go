package helper

import (
    "os"
    "time"

    "github.com/rs/zerolog/log"

    "github.com/beevik/ntp"
)

// checkSystemTime compares the system time with an NTP server time and returns whether it's correct within the given threshold
func CheckSystemTime() bool {
    log.Info().Msg("Checking if System Time is correct...")
    threshold := 10 * time.Second

    // Get the time from an NTP server
    ntpTime, err := ntp.Time("pool.ntp.org")
    if err != nil {
        log.Info().Msgf("Failed to get NTP time: %v", err)
        return true
    }

    // Get the current system time
    systemTime := time.Now()

    // Calculate the difference between system time and NTP time
    timeDifference := systemTime.Sub(ntpTime)

    // Check if the time difference is within the acceptable threshold
    if timeDifference > -threshold && timeDifference < threshold {
        log.Info().Msg("System Time is correct...")
    } else {
        log.Info().Msg("ERROR: System Time incorrect, please correct your systemtime:")
        log.Info().Msgf("System time: %v", systemTime)
        log.Info().Msgf("NTP time: %v", ntpTime)
        log.Info().Msgf("Aborting command!", )
        os.Exit(1)
    }
    return timeDifference > -threshold && timeDifference < threshold
}
