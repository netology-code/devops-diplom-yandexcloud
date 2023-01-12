variable yc_zone {
  type    = string
  default = "ru-central1-b"
  description = "Zone"
}
variable public_key_path {
  description = "~/.ssh/id_rsa.pub"
}
variable private_key_path {
  description = "~/.ssh/id_rsa"
}
variable yc_cloud_id {
  description = "cloud id"
}
variable yc_folder_id {
  description = "Folder"
}

variable "user" {
  type = string
  default = "yc-user"
}

variable "service_account_key_file" {
  description = "../YC/tf_sa_key.json"
}

variable "lamp-image" {
  default = "fd827b91d99psvq5fjit"
}