# create a new project
data "equinix_metal_project" "my_project" {
  name = var.project-name
}

# generate a random VM name
resource "random_pet" "identity" {
  length    = 2
  separator = "-"
}

# Cloud-init
data "template_file" "cloudconfig" {
  template = file("${var.user-data-file}")
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.cloudconfig.rendered
  }
}


# Reserve an IP
resource "equinix_metal_reserved_ip_block" "load_balancer_ips" {
  project_id = data.equinix_metal_project.my_project.id
  metro   = "AM"
  quantity = 2
}


resource "equinix_metal_spot_market_request" "req" {
  project_id    = data.equinix_metal_project.my_project.id
  max_bid_price = var.max-bid
  metro         = "${var.spot-metro}"
  devices_min   = var.min-nodes
  devices_max   = var.max-nodes

  instance_parameters {
    always_pxe       = false
    billing_cycle    = "${var.billing-cycle}"
    userdata         = file("${var.user-data-file}")
    description      = "${var.description}"
    hostname         = random_pet.identity.id
    operating_system = "${var.operating-system}"
    plan             = "${var.machine-size}"
  }
}

# Get the vm id fromt he spot request
data "equinix_metal_spot_market_request" "dreq" {
  request_id = equinix_metal_spot_market_request.req.id
  depends_on = [ equinix_metal_spot_market_request.req ]
}

# get data about the vm
data "equinix_metal_device" "spot_vm" {
  hostname = random_pet.identity.id
  project_id = data.equinix_metal_project.my_project.id
  depends_on = [ equinix_metal_spot_market_request.req ]
}

output "id" {
  value = data.equinix_metal_spot_market_request.dreq.device_ids
}
