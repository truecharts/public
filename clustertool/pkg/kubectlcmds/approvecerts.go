package kubectlcmds

import (
    "context"
    "time"

    "github.com/rs/zerolog/log"
    certificatesv1 "k8s.io/api/certificates/v1"
    metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
    "k8s.io/client-go/kubernetes"
    "k8s.io/client-go/rest"
    "k8s.io/client-go/tools/clientcmd"
)

// getClientset creates a Kubernetes clientset from the in-cluster config or kubeconfig file
func GetClientset() (*kubernetes.Clientset, error) {
    log.Trace().Msg("Attempting to create Kubernetes clientset")

    // Use the current context in kubeconfig
    config, err := clientcmd.BuildConfigFromFlags("", clientcmd.RecommendedHomeFile)
    if err != nil {
        log.Warn().Err(err).Msg("Failed to load kubeconfig, attempting in-cluster config")
        config, err = rest.InClusterConfig()
        if err != nil {
            log.Error().Err(err).Msg("Failed to create in-cluster config")
            return nil, err
        }
    }

    // Create the clientset
    clientset, err := kubernetes.NewForConfig(config)
    if err != nil {
        log.Error().Err(err).Msg("Error creating Kubernetes clientset")
        return nil, err
    }

    log.Info().Msg("Kubernetes clientset created successfully")
    return clientset, nil
}

// ApprovePendingCertificates approves pending CSRs
func ApprovePendingCertificates(clientset *kubernetes.Clientset, stopCh <-chan struct{}) {
    log.Info().Msg("Waiting to approve certificates...")

    for {
        select {
        case <-stopCh:
            log.Info().Msg("Stopping certificate approval...")
            return
        default:
            // Get the list of pending CSRs
            log.Debug().Msg("Retrieving list of pending CSRs")
            csrList, err := clientset.CertificatesV1().CertificateSigningRequests().List(context.TODO(), metav1.ListOptions{})
            if err != nil {
                log.Error().Err(err).Msg("Error getting CSRs")
                time.Sleep(5 * time.Second)
                continue
            }

            log.Debug().Msgf("Retrieved %d CSRs", len(csrList.Items))

            // Approve pending CSRs
            for _, csr := range csrList.Items {
                log.Debug().Str("CSRName", csr.Name).Msg("Checking CSR for approval")

                if csr.Status.Conditions == nil || len(csr.Status.Conditions) == 0 {
                    // Create a copy of the CSR object
                    csrCopy := csr.DeepCopy()

                    // Prepare approval conditions
                    conditions := []certificatesv1.CertificateSigningRequestCondition{
                        {
                            Type:           certificatesv1.CertificateApproved,
                            Reason:         "AutoApproved",
                            Message:        "This CSR was approved automatically by controller.",
                            LastUpdateTime: metav1.Now(),
                            Status:         "True",
                        },
                    }
                    csrCopy.Status.Conditions = conditions

                    // Update approval for the CSR using the copied object
                    _, err := clientset.CertificatesV1().CertificateSigningRequests().UpdateApproval(context.TODO(), csr.Name, csrCopy, metav1.UpdateOptions{})
                    if err != nil {
                        log.Error().Str("CSRName", csr.Name).Err(err).Msg("Error approving CSR")
                    } else {
                        log.Info().Str("CSRName", csr.Name).Msg("Approved CSR")
                    }
                } else {
                    log.Debug().Str("CSRName", csr.Name).Msg("CSR already has approval conditions")
                }
            }

            // Sleep for 5 seconds before checking again
            time.Sleep(5 * time.Second)
        }
    }
}
