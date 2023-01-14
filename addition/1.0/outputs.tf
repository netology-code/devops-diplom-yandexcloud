output "sa" {
  description = "Service Account"
  value       = yandex_iam_service_account.this
}

output "sa_key" {
  description = "Service Account Key"
  value       = yandex_iam_service_account_api_key.sa-api-key.secret_key
  sensitive   = true
}

output "sa_access_key" {
  description = "Service Account Static Key"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

output "sa_secret_key" {
  description = "Service Account Static Secret Key"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive   = true
}

output "sa_json_key" {
  description = "Service Account Key"
  value       = yandex_iam_service_account_key.sa-auth-key
  sensitive   = true
}

output "sa_json_key_string64" {
  description = "Service Account Key String"
  value = base64encode(jsonencode({
    id                 = yandex_iam_service_account_key.sa-auth-key.id
    service_account_id = yandex_iam_service_account_key.sa-auth-key.service_account_id
    created_at         = yandex_iam_service_account_key.sa-auth-key.created_at
    key_algorithm      = yandex_iam_service_account_key.sa-auth-key.key_algorithm
    public_key         = yandex_iam_service_account_key.sa-auth-key.public_key
    private_key        = yandex_iam_service_account_key.sa-auth-key.private_key
  }))
  sensitive = true
}

output "sa_json_key_terraform" {
  description = "Service Account Key String"
  value = {
    id                 = yandex_iam_service_account_key.sa-auth-key.id
    service_account_id = yandex_iam_service_account_key.sa-auth-key.service_account_id
    created_at         = yandex_iam_service_account_key.sa-auth-key.created_at
    key_algorithm      = yandex_iam_service_account_key.sa-auth-key.key_algorithm
    public_key         = yandex_iam_service_account_key.sa-auth-key.public_key
    private_key        = yandex_iam_service_account_key.sa-auth-key.private_key
  }
  sensitive = true
}


output "bucket_fqdn" {
  description = "Domain of bucket"
  value       = yandex_storage_bucket.netology.bucket_domain_name
}

output "bucket_id" {
  description = "ID of bucket"
  value       = yandex_storage_bucket.netology.id
}