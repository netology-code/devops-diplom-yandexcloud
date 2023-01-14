locals {
  folder_bindings = merge([
    for folder, roles in var.sa_folder_roles : {
      for role in roles : "${folder} ${role}" => {
        folder = folder
        role   = role
      }
    }
  ]...)

  cloud_bindings = merge([
    for cloud, roles in var.sa_cloud_roles : {
      for role in roles : "${cloud} ${role}" => {
        cloud = cloud
        role  = role
      }
    }
  ]...)
}

variable "sa_name" {
  description = "Service Account Name"
  type        = string
  default     = "base-test"
}

variable "sa_roles" {
  description = "Service Account default folder role"
  type        = set(string)
  default     = ["editor"]
}

variable "sa_description" {
  description = "Service Account Description"
  type        = string
  default     = null
}

variable "yc_folder_id" {
  description = "Folder id (default to provider config)"
  type        = string
}

variable "sa_folder_roles" {
  description = "Service Folder Roles"
  type        = map(list(string))
  default     = {}
}

variable "sa_cloud_roles" {
  description = "Service Account Cloud Name"
  type        = map(list(string))
  default     = {}
}

variable "service_account_key_file" {
  description = "../YC/tf_sa_key.json"
}

variable yc_zone {
  type    = string
  default = "ru-central1-b"
  description = "Zone"
}


variable yc_cloud_id {
  description = "cloud id"
}

variable bucket_tf {
  description = "bucket for terraform"
  default = "tf-bucket-neto"
}