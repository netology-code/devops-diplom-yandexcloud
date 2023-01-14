iva@c9v:~/Documents/Diplom/1.0 $ 
iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace list 
* default

iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace new stage
Created and switched to workspace "stage"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace list 
  default
* stage

iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace new prod
Created and switched to workspace "prod"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace list 
  default
* prod
  stage

iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace select stage
Switched to workspace "stage".
iva@c9v:~/Documents/Diplom/1.1 $ terraform workspace list 
  default
  prod
* stage

iva@c9v:~/Documents/Diplom/1.1 $ 

    ]

Do you want to perform these actions in workspace "stage"?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

terraform apply 


yandex_vpc_network.vpcnet: Creating...
yandex_vpc_network.vpcnet: Creation complete after 1s [id=enp01655u6im1473koa3]
yandex_vpc_subnet.vpcsubnet: Creating...
yandex_vpc_subnet.vpcsubnet: Creation complete after 0s [id=e9bfvkfarls52m822ejn]
yandex_compute_instance.vm_count[2]: Creating...
yandex_compute_instance.vm_count[0]: Creating...
yandex_compute_instance.vm_for_each["stage"]: Creating...
yandex_compute_instance.vm_for_each["prod"]: Creating...
yandex_compute_instance.vm_count[1]: Creating...
yandex_compute_instance.vm_count[2]: Still creating... [10s elapsed]
yandex_compute_instance.vm_count[0]: Still creating... [10s elapsed]
yandex_compute_instance.vm_for_each["stage"]: Still creating... [10s elapsed]
yandex_compute_instance.vm_count[1]: Still creating... [10s elapsed]
yandex_compute_instance.vm_for_each["prod"]: Still creating... [10s elapsed]
yandex_compute_instance.vm_count[0]: Still creating... [20s elapsed]
yandex_compute_instance.vm_count[2]: Still creating... [20s elapsed]
yandex_compute_instance.vm_count[1]: Still creating... [20s elapsed]
yandex_compute_instance.vm_for_each["prod"]: Still creating... [20s elapsed]
yandex_compute_instance.vm_for_each["stage"]: Still creating... [20s elapsed]
yandex_compute_instance.vm_for_each["prod"]: Creation complete after 29s [id=fhmcs6gq4rbal4m7brta]
yandex_compute_instance.vm_count[2]: Still creating... [30s elapsed]
yandex_compute_instance.vm_count[0]: Still creating... [30s elapsed]
yandex_compute_instance.vm_count[1]: Still creating... [30s elapsed]
yandex_compute_instance.vm_for_each["stage"]: Still creating... [30s elapsed]
yandex_compute_instance.vm_count[1]: Creation complete after 36s [id=fhmml7jet3ei2qkt3rvt]
yandex_compute_instance.vm_for_each["stage"]: Creation complete after 36s [id=fhmvd7ohe7jukubhhp9h]
yandex_compute_instance.vm_count[0]: Creation complete after 37s [id=fhmd23s888m2l18d93e9]
yandex_compute_instance.vm_count[2]: Creation complete after 38s [id=fhmuq0s2lhjp02m1rqbl]

Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_count = [
  "51.250.94.35",
  "51.250.14.173",
  "51.250.77.172",
]
external_ip_address_each = toset([
  "51.250.79.113",
  "51.250.86.195",
])
internal_ip_address_count = [
  "10.2.0.9",
  "10.2.0.6",
  "10.2.0.12",
]
internal_ip_address_each = toset([
  "10.2.0.19",
  "10.2.0.24",
])
