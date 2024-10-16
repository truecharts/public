package nodestatus

import (
	"errors"
	"path"
	"strings"

	"github.com/rs/zerolog/log"
	"github.com/truecharts/private/clustertool/embed"
	"github.com/truecharts/private/clustertool/pkg/helper"
)

func baseStatusCMD(node string) []string {
	argsslice := [...]string{embed.GetTalosExec(), "--talosconfig=" + path.Join(helper.ClusterPath, "/talos/generated/talosconfig"), "-n", node, "-e", node, "get", "machinestatus"}
	return argsslice[:]
}

func CheckNeedBootstrap(node string) (bool, error) {
	argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}")
	out, err := helper.RunCommand(argsslice, true)
	if err != nil {
		if strings.Contains(string(out), "certificate signed by unknown authority") {
			argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}", "--insecure")
			out2, err2 := helper.RunCommand(argsslice, true)
			if err2 != nil {
				errstring := "status: " + string(out) + " error: " + err2.Error()
				return false, errors.New(errstring)
			}
			if string(out2) != "" && strings.Contains(string(out2), "maintenance") {
				return true, nil
			}
		} else {
			errstring := "status: " + string(out) + " error: " + err.Error()
			return false, errors.New(errstring)
		}
	}
	errstring := "status: " + string(out) + " error: " + err.Error()
	return false, errors.New(errstring)
}

func CheckStatus(node string) (string, error) {
	argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}")
	out, err := helper.RunCommand(argsslice, true)
	if err != nil {
		if strings.Contains(string(out), "certificate signed by unknown authority") {
			argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.stage}", "--insecure")
			out2, err2 := helper.RunCommand(argsslice, true)
			if err2 != nil {
				errstring := "status: " + string(out) + " error: " + err2.Error()
				return "ERROR", errors.New(errstring)
			}
			return string(out2), nil
		} else {
			errstring := "status: " + string(out) + " error: " + err.Error()
			return "ERROR", errors.New(errstring)
		}
	}
	return string(out), nil
}

func CheckReadyStatus(node string) (string, error) {
	argsslice := append(baseStatusCMD(node), "-o", "jsonpath={.spec.status.ready}")
	out, err := helper.RunCommand(argsslice, true)

	if err != nil {
		errstring := "status: " + string(out) + " error: " + err.Error()
		return "ERROR", errors.New(errstring)
	}
	if strings.Contains(string(out), "true") {
		log.Info().Msg("node ready...")
	} else {
		println("Node not Ready...")
	}
	return string(out), nil
}
