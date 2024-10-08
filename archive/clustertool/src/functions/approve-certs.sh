#!/usr/bin/sudo bash

approve_certs(){
finished=false
echo "Waiting to approve certificates..."
while ! $finished; do
    kubectl certificate approve $(kubectl get csr --sort-by=.metadata.creationTimestamp | grep Pending | awk '{print $1}') >>/dev/null && finished=true
    sleep 5
    kubectl certificate approve $(kubectl get csr --sort-by=.metadata.creationTimestamp | grep Pending | awk '{print $1}') >>/dev/null && finished=true
    sleep 5
    kubectl certificate approve $(kubectl get csr --sort-by=.metadata.creationTimestamp | grep Pending | awk '{print $1}') >>/dev/null && finished=true
done
}
export approve_certs
