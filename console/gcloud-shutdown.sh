#!/usr/bin/env sh

# Remove the cluster (and contents)
gcloud container clusters delete spinnaker-tutorial

# Remove the compute disks (TODO)
# DISKS=$(gcloud compute disks list | )
# gcloud compute disks delete $DISKS

# Remove spinnaker storage account
# gcloud iam service-accounts delete spinnaker-storage-account@$GCLOUD_PROJECT.iam.gserviceaccount.com
