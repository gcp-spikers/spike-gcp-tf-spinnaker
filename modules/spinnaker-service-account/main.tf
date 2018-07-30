resource "google_service_account" "spinnaker-storage-account" {
  account_id = "spinnaker-storage-account"
  project    = "${var.project}"
}

resource "google_service_account_iam_member" "admin-account-iam" {
  service_account_id = "${google_service_account.spinnaker-storage-account.name}"
  role               = "roles/storage.admin"
  member             = "serviceAccount:${google_service_account.spinnaker-storage-account.email}"
}

resource "google_service_account_key" "spinnaker-sa" {
  service_account_id = "${google_service_account.spinnaker-storage-account.name}"
}

# resource "kubernetes_secret" "google-application-credentials" {
#   metadata {
#     name = "google-application-credentials"
#   }


#   data {
#     credentials.json = "${base64decode(google_service_account_key.spinnaker-sa.private_key)}"
#   }
# }

