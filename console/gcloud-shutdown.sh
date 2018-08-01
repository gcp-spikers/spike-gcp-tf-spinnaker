#!/usr/bin/env sh

# Delete spinnaker's service account
export SA_EMAIL=$(gcloud iam service-accounts list \
  --filter="displayName:spinnaker-storage-account" \
  --format='value(email)')
# TODO: can we give the main service account access to remove other service accounts?
gcloud iam service-accounts delete $SA_EMAIL --quiet

# Remove the cluster (and contents)
gcloud container clusters delete spinnaker-tutorial --quiet

# TODO: establish query to remove only our relevant disks
# Remove the compute bucket
export PROJECT=$(gcloud info --format='value(config.project)')
export BUCKET=$PROJECT-spinnaker-config
gsutil -m rm -r gs://$BUCKET

