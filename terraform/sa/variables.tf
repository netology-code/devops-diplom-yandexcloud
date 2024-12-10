###cloud vars
variable "token" {
  type        = string
  sensitive   = true
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

###sa vars
variable "sa_name" {
  type      = string
  default   = "kig"  
}

variable "bucket" {
  type      = string
  default   = "diplom-bucket-kig"
}
