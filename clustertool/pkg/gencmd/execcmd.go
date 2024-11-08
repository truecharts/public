package gencmd

import (
    "os"
    "strings"
    "time"

    "github.com/rs/zerolog/log"
    "github.com/truecharts/public/clustertool/pkg/helper"
    "github.com/truecharts/public/clustertool/pkg/nodestatus"
)

func ExecCmd(cmd string) {
    argslice := strings.Split(cmd, " ")
    log.Trace().Msgf("command", argslice[:])

    // log.Info().Msg("test", strings.Join(argslice, " "))
    out, err := helper.RunCommand(argslice, false)
    if err != nil {
        log.Info().Msgf("err:  %v", err)
        if strings.Contains(cmd, "bootstrap") {
            log.Info().Msg("Bootstrap: Fail, retrying...")
            time.Sleep(5 * time.Second)
            out, err = helper.RunCommand(argslice, false)

            if err != nil && strings.Contains(string(out), "bootstrap is not available yet") {
                start := time.Now()
                timeout := 2 * time.Minute

                for {
                    log.Info().Msg("Bootstrap: Fail, retrying...")
                    time.Sleep(5 * time.Second)

                    out, err = helper.RunCommand(argslice, false)
                    if err != nil || !strings.Contains(string(out), "bootstrap is not available yet") {
                        break
                    }
                    if time.Since(start) >= timeout {
                        log.Info().Msg("Timeout reached: Node not ready for bootstrap within 2 minutes.")
                        break
                    }
                }
            }
        }

    }
}

func ExecCmds(taloscmds []string, healthcheck bool) error {
    log.Info().Msg("Regenerating config prior to commands...")
    GenConfig([]string{})
    var todocmds []string
    var healthcmd string
    skipped := false
    if healthcheck {
        log.Info().Msg("Pre-Run Healthchecks...")

        for _, command := range taloscmds {

            node := helper.ExtractNode(command)
            log.Info().Msgf("checking node availability:  %v", node)
            err := nodestatus.CheckHealth(node, "", false)
            if err != nil {
                log.Info().Msgf("node seems not to be runnign correctly and cannot be used %v", node)
                log.Info().Msgf("node This will also make it impossible to poll total-cluster-health as well... %v", node)
                if !helper.GetYesOrNo("Do you want to continue without this node? (yes/no) [y/n]: ") {
                    log.Info().Msg("Exiting...")
                    os.Exit(1)
                } else {
                    skipped = true
                }
            }
            todocmds = append(todocmds, command)
        }
        if skipped {
            log.Info().Msg("skipping cluster health check due to unhealthy nodes being ignored...")
        } else {
            if helper.GetYesOrNo("Do you want to check the health of the cluster? (yes/no) [y/n]: ") {
                log.Info().Msg("Checking if cluster is healthy...")
                healthcmd := GenPlain("health", helper.TalEnv["VIP_IP"], []string{})
                ExecCmd(healthcmd[0])
            } else {
                skipped = true
            }
        }
    } else {
        todocmds = taloscmds
    }

    log.Info().Msg("Executing Cmds...")
    for _, command := range todocmds {
        node := helper.ExtractNode(command)
        log.Info().Msgf("Executing commands on node:  %v", node)
        argslice := strings.Split(string(command), " ")
        // log.Info().Msg("test", strings.Join(argslice, " "))
        log.Debug().Msgf("running command: %s", command)
        out, err := helper.RunCommand(argslice, false)
        if err != nil {
            if strings.Contains(string(out), "certificate signed by unknown authority") {
                argslice = append(argslice, "--insecure")
                log.Debug().Msgf("Re-Running command using insecure flag: %s", command)
                _, err2 := helper.RunCommand(argslice, false)
                if err2 != nil {
                    log.Info().Msgf("err:  %v", err2)
                }
            } else {
                log.Info().Msgf("err:  %v", err)
                log.Info().Msgf("node has thrown an error... %v", node)
                if !helper.GetYesOrNo("Are you sure you want to continue applying this to other nodes? (yes/no) [y/n]: ") {
                    log.Info().Msg("Exiting...")
                    os.Exit(1)
                }

            }

        }
        time.Sleep(15 * time.Second)

        if healthcheck {
            log.Info().Msgf("checking if node is back online:  %v", node)
            err := nodestatus.CheckHealth(node, "", false)
            if err != nil {
                log.Info().Msgf("node seems not to be running correctly... %v", node)
                if !helper.GetYesOrNo("Are you sure you want to continue applying this to other nodes? (yes/no) [y/n]: ") {
                    log.Info().Msg("Exiting...")
                    os.Exit(1)
                }
            }
        }
    }

    if healthcheck && !skipped && !strings.Contains(taloscmds[0], "upgrade") {
        log.Info().Msg("Checking if cluster is healthy after commands...")
        ExecCmd(healthcmd)
    }
    return nil
}
