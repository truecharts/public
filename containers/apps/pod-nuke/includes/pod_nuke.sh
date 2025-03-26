#!/bin/bash

# Ensure we're using Bash
if [ -z "$BASH_VERSION" ]; then
    echo "This script requires Bash. Please install it on Alpine: apk add bash"
    exit 1
fi

# Keep track of nodes that have failed
declare -A failed_nodes
# Keep track of nodes where pods have already been removed
declare -A processed_nodes

while true; do
    # Get all nodes and their readiness status
    while read -r node status extra; do
        # Ensure NotReady is in the status field (handling additional conditions)
        if echo "$status" | grep -q "NotReady"; then
            # If node is newly failed, start a 15-minute timer
            if [[ -z "${failed_nodes[$node]}" && -z "${processed_nodes[$node]}" ]]; then
                echo "Node $node is NotReady, starting timer."
                failed_nodes[$node]=$(date +%s)
            else
                # Check if 15 minutes have passed
                start_time=${failed_nodes[$node]}
                current_time=$(date +%s)
                elapsed=$((current_time - start_time))

                if [[ $elapsed -ge 900 ]]; then
                    echo "15 minutes elapsed, checking for running or terminating pods on $node."
                    pods=$(kubectl get pods --all-namespaces --field-selector spec.nodeName==$node --no-headers | awk '$4 == "Running" || $4 == "Terminating" {print $2 " " $1}')

                    if [[ -z "$pods" ]]; then
                        echo "No running or terminating pods found on $node."
                    else
                        echo "$pods" | while read -r pod namespace; do
                            echo "Force deleting pod $pod in namespace $namespace on node $node"
                            kubectl delete pod "$pod" -n "$namespace" --force --grace-period=0
                        done
                        processed_nodes[$node]=1  # Mark node as processed after deleting pods
                    fi
                    unset failed_nodes[$node]
                fi
            fi
        else
            # If node recovers, remove it from failed and processed tracking
            if [[ -n "${failed_nodes[$node]}" || -n "${processed_nodes[$node]}" ]]; then
                echo "Node $node recovered, removing from tracking."
                unset failed_nodes[$node]
                unset processed_nodes[$node]
            fi
        fi
    done < <(kubectl get nodes --no-headers | awk '{print $1 " " $2 " " $3}')

    # Sleep for a short period before checking again
    sleep 60
done
