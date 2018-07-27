#!/usr/bin/env sh

# Have the following APIs enabled
# Kubernetes Engine, Container Builder, and Resource Manager 

###### BASE INFRA ######

# Set default zone
export ZONE="australia-southeast1-a"
export REGION="australia-southeast1"
gcloud config set compute/zone $ZONE

# Create cluster
gcloud container clusters create spinnaker-tutorial \
--machine-type=n1-standard-2

# Create spinnaker service account for storage access
gcloud iam service-accounts create  spinnaker-storage-account \
    --display-name spinnaker-storage-account

# Save values for serviceaccount email and project ID
export SA_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:spinnaker-storage-account" \
    --format='value(email)')
export PROJECT=$(gcloud info --format='value(config.project)')



# 'storage.admin' role binding for service account
gcloud projects add-iam-policy-binding \
    $PROJECT --role roles/storage.admin --member serviceAccount:$SA_EMAIL


# Download service account credentials key
gcloud iam service-accounts keys create spinnaker-sa.json --iam-account $SA_EMAIL

###### INSTALL HELM ######

# Download helm binary
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.7.2-linux-amd64.tar.gz

# Unzip and cp
tar zxfv helm-v2.7.2-linux-amd64.tar.gz
cp linux-amd64/helm .

# Give 'Tiller' cluster-admin role in cluster

kubectl create clusterrolebinding user-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-admin-binding --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

# Give Spinnaker the 'cluster-admin' role for the entire cluster
kubectl create clusterrolebinding --clusterrole=cluster-admin --serviceaccount=default:default spinnaker-admin

# Initialize helm to install Tiller in cluster
./helm init --service-account=tiller
./helm update

###### SPINNAKER CONFIG ######

# Create bucket for Spinnaker pipeline config
BUCKET=$PROJECT-spinnaker-config
gsutil mb -c regional -l $REGION gs://$BUCKET

export SA_JSON=$(cat spinnaker-sa.json)

# Create spinnaker-config.yaml file

cat > spinnaker-config.yaml <<EOF
storageBucket: $BUCKET
gcs:
  enabled: true
  project: $PROJECT
  jsonKey: '$SA_JSON'

# Disable minio as the default
minio:
  enabled: false


# Configure your Docker registries here
accounts:
- name: gcr
  address: https://gcr.io
  username: _json_key
  password: '$SA_JSON'
  email: 1234@5678.com
EOF


###### DEPLOY SPINNAKER ######

# Install helm chart with spinnaker-config.yaml
./helm install -n cd stable/spinnaker -f spinnaker-config.yaml --timeout 600 \
    --version 0.3.1

# Initiate port forwarding to access Spinnaker UI
export DECK_POD=$(kubectl get pods --namespace default -l "component=deck" \
    -o jsonpath="{.items[0].metadata.name}")
kubectl port-forward --namespace default $DECK_POD 8080:9000 >> /dev/null &

# Click web-preview in cloudshell and click 'Preview on port 8080'
