output "service_account_id" {
  description = "ID сервисного аккаунта"
  value       = yandex_iam_service_account.terraform.id
}

output "bucket_name" {
  description = "Имя bucket для terraform state"
  value       = yandex_storage_bucket.tfstate.bucket
}

output "bucket_endpoint" {
  description = "S3 endpoint"
  value       = "https://storage.yandexcloud.net"
}

output "backend_access_key" {
  description = "Access key для backend"
  value       = yandex_iam_service_account_static_access_key.terraform_s3_key.access_key
  sensitive   = true
}

output "backend_secret_key" {
  description = "Secret key для backend"
  value       = yandex_iam_service_account_static_access_key.terraform_s3_key.secret_key
  sensitive   = true
}

output "kms_key_id" {
  description = "ID KMS ключа для шифрования"
  value       = yandex_kms_symmetric_key.tfstate_key.id
}


output "next_step_instructions" {
  description = "Инструкция по переходу к этапу инфраструктуры"
  value       = <<INSTRUCTIONS
✅ Bootstrap завершён!

Далее:
1. Скопируйте значения ниже в infrastructure/terraform.tfvars:
   - backend_access_key
   - backend_secret_key  
   - bucket_name

2. Перейдите в папку infrastructure/
3. Запустите: terraform init -backend-config="access_key=..." -backend-config="secret_key=..."
4. Выполните: terraform apply

⚠️  Секретные ключи не сохраняются в логах благодаря sensitive=true
INSTRUCTIONS
}