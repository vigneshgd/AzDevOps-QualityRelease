# Azure subscription vars
subscription_id = "97753398-f685-4bc7-a3e9-9b86929f6c92"
client_id = "d26cfadd-5d18-4682-b920-ae7320ad41dc"
#client_id = "7314ea59-8b82-4a9f-a461-a8be943a71f5"
client_secret = "13nE2-DL..0gSs1JW7HGL-GMd-Rx2vkH-H"
#client_secret = "S41Kwe2uT-W~_nL78.uwYKM~u8.Wc4Plda"
tenant_id = "29913035-c436-4a18-9abf-c2348f989187"

# Resource Group/Location
location = "eastus"
resource_group = "qualityrelease"
application_type = "qualityrelease"
sku_tier = "Free"
sku_size = "F1"

# Tags
tier = "Test"
deployment = "Terraform"

# Network
virtual_network_name = "VirtNet"
address_space = ["10.5.0.0/16"]
address_prefix_test = ["10.5.1.0/24"]
#VM
vm_size = "Standard_D2s_v3"
admin_user = "devopsadmin"
vm_ssh_key = "AAAAB3NzaC1yc2EAAAABIwAAAQEArIood27UiDWIquKG6eT/vaMeCdVdcIEnzFn9UAMCd9RRQrESQKXSpMhpJWA9KDOOlHKG2R/uqDqv2z4hxRy3vCyTj+J9EnWnoFvPkiQijCQ4K+KcF9dEL7EP4WQD9H5eYGl0HyoKx6vzSBt3ZQydWOOfTdCGQueSpjp2b+hpFZvg6D54EVtCXzdQhkMTL30ehPZjdCwu6M2dzOILGJpfathb4S1DzTVaerujm3uPTCtfchOkQJb4TUFbraU56vb9fzs7HHh2hWOCvrkgRAkBiqO2BwdS+vRvfxN9l3u1j99n3gBrxDkDqJ32FZ7iTif77sA1c57j2dnIs3LUS3U6kw== qualityrelease"
#subnet_id_test = ""