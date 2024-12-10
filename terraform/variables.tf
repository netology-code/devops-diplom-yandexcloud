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

variable "vpc_name" {
  type        = string
  default     = "my_vpc"
  description = "VPC network&subnet name"
}

variable "subnet_name" {
  type        = string
  default     = "my_subnet"
  description = "Name of public subnet"
}

variable "cidr" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

###s3 vars

variable "sa_name" {
  type        = string
  default     = "reocoker"
  description = "Name of service account"
}
