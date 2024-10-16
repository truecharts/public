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
	// use the current context in kubeconfig
	config, err := clientcmd.BuildConfigFromFlags("", clientcmd.RecommendedHomeFile)
	if err != nil {
		config, err = rest.InClusterConfig()
		if err != nil {
			return nil, err
		}
	}

	// create the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		return nil, err
	}

	return clientset, nil
}

// Example function to approve pending CSRs
func ApprovePendingCertificates(clientset *kubernetes.Clientset, stopCh <-chan struct{}) {
	log.Info().Msg("Waiting to approve certificates...")

	for {
		select {
		case <-stopCh:
			log.Info().Msg("Stopping certificate approval...")
			return
		default:
			// Get the list of pending CSRs
			csrList, err := clientset.CertificatesV1().CertificateSigningRequests().List(context.TODO(), metav1.ListOptions{})
			if err != nil {
				log.Info().Msgf("Error getting CSRs: %v", err)
				time.Sleep(5 * time.Second)
				continue
			}

			// Approve pending CSRs
			for _, csr := range csrList.Items {
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
						log.Info().Msgf("Error approving CSR %s: %v\n", csr.Name, err)
					} else {
						log.Info().Msgf("Approved CSR", csr.Name)
					}
				}
			}

			// Sleep for 5 seconds before checking again
			time.Sleep(5 * time.Second)
		}
	}
}
