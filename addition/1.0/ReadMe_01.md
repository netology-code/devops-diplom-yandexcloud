```
iva@c9v:~/Documents/Diplom/1.0 $ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_iam_service_account.this will be created
  + resource "yandex_iam_service_account" "this" {
      + created_at = (known after apply)
      + folder_id  = "b1gm6im3mcuc36r6kn8s"
      + id         = (known after apply)
      + name       = "base-test"
    }

  # yandex_iam_service_account_api_key.sa-api-key will be created
  + resource "yandex_iam_service_account_api_key" "sa-api-key" {
      + created_at           = (known after apply)
      + description          = "api key for authorization"
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = (known after apply)
    }

  # yandex_iam_service_account_key.sa-auth-key will be created
  + resource "yandex_iam_service_account_key" "sa-auth-key" {
      + created_at            = (known after apply)
      + description           = "json key for service account"
      + encrypted_private_key = (known after apply)
      + format                = "PEM_FILE"
      + id                    = (known after apply)
      + key_algorithm         = "RSA_2048"
      + key_fingerprint       = (known after apply)
      + private_key           = (sensitive value)
      + public_key            = (known after apply)
      + service_account_id    = (known after apply)
    }

  # yandex_iam_service_account_static_access_key.sa-static-key will be created
  + resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
      + access_key           = (known after apply)
      + created_at           = (known after apply)
      + description          = "static access key for object storage"
      + encrypted_secret_key = (known after apply)
      + id                   = (known after apply)
      + key_fingerprint      = (known after apply)
      + secret_key           = (sensitive value)
      + service_account_id   = (known after apply)
    }

  # yandex_resourcemanager_folder_iam_binding.this["editor"] will be created
  + resource "yandex_resourcemanager_folder_iam_binding" "this" {
      + folder_id = "b1gm6im3mcuc36r6kn8s"
      + id        = (known after apply)
      + members   = (known after apply)
      + role      = "editor"
    }

  # yandex_storage_bucket.netology will be created
  + resource "yandex_storage_bucket" "netology" {
      + access_key         = (known after apply)
      + acl                = "private"
      + bucket             = "tf-bucket-neto"
      + bucket_domain_name = (known after apply)
      + force_destroy      = false
      + id                 = (known after apply)
      + secret_key         = (sensitive value)
      + website_domain     = (known after apply)
      + website_endpoint   = (known after apply)

      + versioning {
          + enabled = (known after apply)
        }
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + sa                 = {
      + created_at  = (known after apply)
      + description = null
      + folder_id   = "b1gm6im3mcuc36r6kn8s"
      + id          = (known after apply)
      + name        = "base-test"
      + timeouts    = null
    }
  + sa_access_key      = (known after apply)
  + sa_json_key        = (sensitive value)
  + sa_json_key_string = (sensitive value)
  + sa_key             = (sensitive value)
  + sa_secret_key      = (sensitive value)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
iva@c9v:~/Documents/Diplom/1.0 $ terraform apply -auto-approve
...

iva@c9v:~/Documents/Diplom/1.0 $ terraform output -json sa_json_key_terraform >../YC/sa_json_key_terraform.json

```