package main

import (
    "fmt"
    "os"
    "time"

    "github.com/rs/zerolog"
    "github.com/rs/zerolog/log"

    "github.com/go-logr/zerologr"
    "github.com/truecharts/public/clustertool/cmd"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
    k8slog "sigs.k8s.io/controller-runtime/pkg/log"
)

var Version = "dev"
var noColor = false

func main() {
    // Configure zerolog
    zerolog.DurationFieldUnit = time.Second

    var zerologLevel zerolog.Level

    // Switch-case for setting the global log level
    switch os.Getenv("LOGLEVEL") {
    case "trace":
        zerologLevel = zerolog.TraceLevel
    case "debug":
        zerologLevel = zerolog.DebugLevel
    case "warn":
        zerologLevel = zerolog.WarnLevel
    case "error":
        zerologLevel = zerolog.ErrorLevel
    case "fatal":
        zerologLevel = zerolog.FatalLevel
    case "panic":
        zerologLevel = zerolog.PanicLevel
    case "info":
        zerologLevel = zerolog.InfoLevel
    default:
        zerologLevel = zerolog.InfoLevel
    }

    if os.Getenv("DEBUG") != "" {
        noColor = true
    }

    // Set zerolog level
    zerolog.SetGlobalLevel(zerologLevel)
    log.Logger = log.Output(zerolog.ConsoleWriter{
        Out:        os.Stdout,
        TimeFormat: time.RFC3339, // Keep this for the timestamp format
        NoColor:    noColor,      // Set to true if you prefer no color
    })

    // Initialize zerolog with console output
    zlogger := zerolog.New(os.Stderr).With().Timestamp().Logger()

    // Wrap zerolog with zerologr to create a logr.Logger
    logger := zerologr.New(&zlogger)

    // Set this logger for dependencies expecting log.SetLogger
    k8slog.SetLogger(logger)

    fmt.Printf("\n%s\n", helper.Logo)
    fmt.Printf("---\nClustertool Version: %s\n---\n", Version)

    embed.AllToCache()

    helper.CheckSystemTime()
    helper.CheckReqDomains()

    err := cmd.Execute()
    if err != nil {
        log.Fatal().Err(err).Msg("Failed to execute command")
    }
}
