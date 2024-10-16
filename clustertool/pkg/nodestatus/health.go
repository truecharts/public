package nodestatus

import (
	"errors"
	"strings"
	"time"

	"github.com/rs/zerolog/log"
)

func CheckHealth(node string, status string, silent bool) error {
	out, err := CheckStatus(node)
	if err != nil {
		errstring := "healthcheck failed. status: " + string(out) + " error: " + err.Error()
		if !silent {
			log.Info().Msgf("Healthcheck: check on node : failed %v", node)
			log.Info().Msgf("failed with error:  %s", errstring)
		}
		return errors.New(errstring)
	}
	out = strings.TrimSpace(out)
	if !silent {
		log.Info().Msgf("Healthcheck: node currently reporting status:  %v %v", node, out)
	}
	if status != "" && strings.Contains(string(out), status) {
		if !silent {
			response := "Healthcheck: detected node " + node + "in mode " + status + " , continuing..."
			log.Info().Msg(response)
		}
	} else if status == "" && strings.Contains(string(out), "maintenance") {
		response := "Healthcheck: WARN detected node " + node + "in mode " + "maintenance" + ".\nLikely a new node, so trying commands anyway. Continuing..."
		log.Info().Msg(response)
	} else if status == "" && strings.Contains(string(out), "running") {
		_, err = CheckReadyStatus(node)
		if err != nil {
			errstring := "healthcheck failed. status: " + string(out) + " error: " + err.Error()
			return errors.New(errstring)
		}
	} else {
		if !silent {
			log.Info().Msgf("Healthcheck: check on node : failed %v", node)
		}
		return errors.New("healthcheck failed")
	}
	return nil
}

func WaitForHealth(node string, status []string) (string, error) {
	statusmsg := ""
	if len(status) > 0 {
		for _, check := range status {
			statusmsg = statusmsg + ", " + check
		}
	} else {
		statusmsg = "running"
		status = []string{""}
	}

	// Corrected log with format specifiers
	log.Info().Msgf("Healthcheck: Waiting for Node %s to reach status: %s", node, statusmsg)

	// Duration constants
	checkInterval := 10 * time.Second
	maxDuration := 15 * time.Minute

	// Create a ticker to run CheckHealth every 10 seconds
	ticker := time.NewTicker(checkInterval)
	defer ticker.Stop()

	// Create a timer to stop the process after 15 minutes
	timer := time.NewTimer(maxDuration)
	defer timer.Stop()

	// Initial health check before starting the ticker
	for _, check := range status {
		err := CheckHealth(node, check, true)
		if err == nil {
			return check, nil
		}
	}

	// Loop to run CheckHealth every 10 seconds for a maximum of 15 minutes
	for {
		select {
		case <-ticker.C:
			for _, check := range status {
				err := CheckHealth(node, check, true)
				if err == nil {
					return check, nil
				}
			}

		case <-timer.C:
			log.Info().Msg("Max duration reached. Stopping health checks.")
			return "ERROR", errors.New("timeout waiting for Node to boot")
		}
	}
}
