variable "yc_cloud_id" {
  description = "Cloud"
}
variable "yc_folder_id" {
  description = "Folder"
}
variable "yc_zone" {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}

variable "yc_image_family" {
  default = "ubuntu-2004-lts" # "fd8takuai2fl6ohntoqj"
}

variable "yc_image_id" {
  default = "fd8takuai2fl6ohntoqj"
}



variable "public_key_path" {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable "service_account_key_file" {
  description = "key .json"
}
variable "private_key_path" {
  description = "Path to Private Key File"
}

variable "sa_id" {
  description = "SERVICE ACCOUNT ID"
}

variable "ssh_user" {
  default = "amsible"
}

variable "workspace_name" {
  type    = string
  default = "stage"
}

variable "meta_file" {
  description = "Metadata file for ssh"
}
