package nodestatus

import (
    "errors"
    "path"
    "strings"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/embed"
    "github.com/truecharts/public/clustertool/pkg/helper"
)

func baseStatusCMD(node string) []string {
    argsslice := [...]string{embed.GetTalosExec(), "--talosconfig=" + path.Join(helper.ClusterPath, "/talos/generated/talosconfig"), "-n", node, "-e", node, "get", "machinestatus"}

    log.Debug().Strs("command", argsslice[:]).Msg("Constructed base command for machine status")
    return argsslice[:]
}

func CheckNeedBootstrap(node string) (bool, error) {
    log.Info().Str("node", node).Msg("Checking if bootstrap is needed")

    argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}")
    out, err := helper.RunCommand(argsslice, true)
    if err != nil {
        log.Warn().Err(err).Str("output", string(out)).Msg("Error running command, checking for certificate issue")
        if strings.Contains(string(out), "certificate signed by unknown authority") {
            log.Debug().Msg("Certificate signed by unknown authority; retrying with insecure flag")
            argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}", "--insecure")
            out2, err2 := helper.RunCommand(argsslice, true)
            if err2 != nil {
                errstring := "status: " + string(out) + " error: " + err2.Error()
                log.Error().Msg(errstring)
                return false, errors.New(errstring)
            }
            if string(out2) != "" && strings.Contains(string(out2), "maintenance") {
                log.Info().Msg("Node is in maintenance; bootstrap needed")
                return true, nil
            }
        } else {
            errstring := "status: " + string(out) + " error: " + err.Error()
            log.Error().Msg(errstring)
            return false, errors.New(errstring)
        }
    }
    log.Debug().Str("output", string(out)).Msg("No bootstrap needed; returning false")
    return false, nil
}

func CheckStatus(node string) (string, error) {
    log.Info().Str("node", node).Msg("Checking node status")

    argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}")
    out, err := helper.RunCommand(argsslice, true)
    if err != nil {
        log.Debug().Err(err).Str("output", string(out)).Msg("Error running command, checking for certificate issue")
        if strings.Contains(string(out), "certificate signed by unknown authority") {
            log.Debug().Msg("Certificate signed by unknown authority; retrying with insecure flag")
            argsslice = append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}", "--insecure")
            out2, err2 := helper.RunCommand(argsslice, true)
            if err2 != nil {
                errstring := "status: " + string(out) + " error: " + err2.Error()
                log.Error().Msg(errstring)
                return "ERROR", errors.New(errstring)
            }
            log.Info().Msg("Successfully retrieved node status with insecure flag")
            return string(out2), nil
        } else {
            errstring := "status: " + string(out) + " error: " + err.Error()
            log.Error().Msg(errstring)
            return "ERROR", errors.New(errstring)
        }
    }
    log.Info().Str("status", string(out)).Msg("Node status retrieved successfully")
    return string(out), nil
}

func CheckReadyStatus(node string, silent bool) (string, error) {
    log.Info().Str("node", node).Msg("Checking node readiness status")

    argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.status.ready}")
    out, err := helper.RunCommand(argsslice, true)

    if err != nil {
        errstring := "status: " + string(out) + " error: " + err.Error()
        if !silent {
            log.Error().Msg(errstring)
        }
        return "ERROR", errors.New(errstring)
    }
    if strings.Contains(string(out), "true") {
        log.Info().Msg("Node is ready")
    } else {
        log.Warn().Msg("Node is not ready")
    }
    return string(out), nil
}
