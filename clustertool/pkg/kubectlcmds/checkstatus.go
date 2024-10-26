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
    log.Trace().Msg("Starting CheckStatus function")

    // Load kubeconfig from the default location
    kubeconfig := clientcmd.NewDefaultClientConfigLoadingRules().GetDefaultFilename()
    config, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
    if err != nil {
        log.Error().Err(err).Msg("Error loading kubeconfig")
        return fmt.Errorf("error loading kubeconfig: %w", err)
    }
    log.Debug().Msg("Kubeconfig loaded successfully")

    // Create clientset
    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        log.Error().Err(err).Msg("Error creating Kubernetes clientset")
        return fmt.Errorf("error creating clientset: %w", err)
    }
    log.Debug().Msg("Kubernetes clientset created successfully")

    // Maximum duration to wait (timeout in minutes)
    maxDuration := timeout * time.Minute
    endTime := time.Now().Add(maxDuration)

    log.Info().Msg("Checking status of required pods")
    log.Debug().Msgf("required pods: %v, excluding pods: %v", requiredPods, excludePod)

    for time.Now().Before(endTime) {
        log.Debug().Msg("Retrieving list of pods")

        // Get pods in all namespaces
        pods, err := clientset.CoreV1().Pods("").List(context.TODO(), metav1.ListOptions{})
        if err != nil {
            log.Debug().Err(err).Msg("Error listing pods")
            log.Warn().Msg("Cannot recieve pods (yet), waiting before checking again")
            time.Sleep(5 * time.Second)
            continue
        }

        // Check if the required pods are both present and running
        requiredPodsMap := make(map[string]bool)
        for _, pod := range requiredPods {
            requiredPodsMap[pod] = false
        }

        log.Debug().Msg("Checking pod statuses")
        for _, pod := range pods.Items {
            for _, requiredPod := range requiredPods {
                for _, excludePod := range excludePod {
                    if strings.Contains(pod.Name, excludePod) {
                        log.Debug().Str("excludedPod", excludePod).Msg("Excluding pod from check")
                        requiredPodsMap[requiredPod] = true
                    }
                }
                if strings.Contains(pod.Name, requiredPod) && pod.Status.Phase == "Running" {
                    requiredPodsMap[requiredPod] = true
                    log.Debug().Str("podName", pod.Name).Msgf("Required pod %s is running", requiredPod)
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

        log.Warn().Msg("Not all required pods are running, waiting before checking again")
        // Wait for 5 seconds before checking again
        time.Sleep(5 * time.Second)
    }

    log.Error().Msg("Timeout: Not all required pods are running after 15 minutes")
    return fmt.Errorf("timeout: not all required pods are running after 15 minutes")
}
