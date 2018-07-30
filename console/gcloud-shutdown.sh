#!/usr/bin/env sh

# Remove the cluster (and contents)
gcloud container clusters delete spinnaker-tutorial

# TODO: establish query to remove only our relevant disks
# Remove the compute disks
# DISKS=$(gcloud compute disks list | )
# gcloud compute disks delete $DISKS

# TODO: can we give the main service account access to remove other service accounts?
# Remove spinnaker storage account
# gcloud iam service-accounts delete spinnaker-storage-account@$GCLOUD_PROJECT.iam.gserviceaccount.com
