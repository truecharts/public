package kubectlcmds

import (
	"context"
	"fmt"
	"strings"
	"time"

	"github.com/rs/zerolog/log"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
)

func CheckStatus(requiredPods []string, excludePod []string, timeout time.Duration) error {
	// Load kubeconfig from the default location
	kubeconfig := clientcmd.NewDefaultClientConfigLoadingRules().GetDefaultFilename()
	config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		return fmt.Errorf("error loading kubeconfig: %w", err)
	}

	// Create clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		return fmt.Errorf("error creating clientset: %w", err)
	}

	// Maximum duration to wait (15 minutes)
	maxDuration := timeout * time.Minute
	endTime := time.Now().Add(maxDuration)

	for time.Now().Before(endTime) {
		// Get pods in all namespaces
		pods, err := clientset.CoreV1().Pods("").List(context.TODO(), metav1.ListOptions{})
		if err != nil {
			// return fmt.Errorf("error listing pods: %w", err)
		}

		// Check if the required pods are both present and running
		requiredPodsMap := make(map[string]bool)
		for _, pod := range requiredPods {
			requiredPodsMap[pod] = false
		}

		for _, pod := range pods.Items {
			for _, requiredPod := range requiredPods {
				for _, excludePod := range excludePod {
					if strings.Contains(pod.Name, excludePod) {
						requiredPodsMap[requiredPod] = true
					}
				}
				if strings.Contains(pod.Name, requiredPod) && pod.Status.Phase == "Running" {
					requiredPodsMap[requiredPod] = true
				}
			}
		}

		allRunning := true
		for _, isRunning := range requiredPodsMap {
			if !isRunning {
				allRunning = false
				break
			}
		}

		if allRunning {
			log.Info().Msg("All required pods are running")
			return nil
		}

		// Wait for 5 seconds before checking again
		time.Sleep(5 * time.Second)
	}

	return fmt.Errorf("timeout: not all required pods are running after 15 minutes")
}
