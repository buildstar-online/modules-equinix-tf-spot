# Equinix Metal: Spot Instances

https://deploy.equinix.com/metal/

Equinix Metal is an automated colocation service. They allow spot-bidding on their unused metal capacity at prices are very competetive with the major cloud prviders. Their severs are generally top-of-the-line and more performant than other similarly priced cloud-instances. 

See the available sever configurations here: https://deploy.equinix.com/product/servers/

## Account

You will need an API Key in order to use the Equinix Terraform provider. You will need to sign-up for an account with Equinix Metal to get that.
Equinix often flags new accounts for extra verification data so don't be surprised to get an email asking you to verify your identity, organization, use-case etc...

Once you have an account, you can create an API Key from your account settings page. Add that key to the `providers.tf` file.

## Usage

1. Create a spot market request first, it will need to be fulfilled / rejected before other resources can be deduced

    ```bash
    docker pull hashicorp/terraform:latest && \
        docker run --platform linux/amd64 -it \
        -v $(pwd):/workspace \
        -w /workspace \
        hashicorp/terraform:latest apply -target equinix_metal_spot_market_request.req
    ```

2. Apply the rest of the resources. this should now provide you with the full details of your instance.

    ```bash
    docker pull hashicorp/terraform:latest && \
        docker run --platform linux/amd64 -it \
        -v $(pwd):/workspace \
        -w /workspace \
        hashicorp/terraform:latest apply
    ```

3. Destroy the spot market request. If you just delete the instance, it will be created again by the request.

    ```bash
    docker pull hashicorp/terraform:latest && \
        docker run --platform linux/amd64 -it \
        -v $(pwd):/workspace \
        -w /workspace \
        hashicorp/terraform:latest destroy -target equinix_metal_spot_market_request.req
    ```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~>2.2.0 |
| <a name="requirement_equinix"></a> [equinix](#requirement\_equinix) | ~>1.10.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~>3.3.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~>0.7.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~>3.4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_equinix"></a> [equinix](#provider\_equinix) | ~>1.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~>3.3.1 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [equinix_metal_reserved_ip_block.load_balancer_ips](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_reserved_ip_block) | resource |
| [equinix_metal_spot_market_request.req](https://registry.terraform.io/providers/equinix/equinix/latest/docs/resources/metal_spot_market_request) | resource |
| [random_pet.identity](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [equinix_metal_device.spot_vm](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_device) | data source |
| [equinix_metal_project.my_project](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_project) | data source |
| [equinix_metal_spot_market_request.dreq](https://registry.terraform.io/providers/equinix/equinix/latest/docs/data-sources/metal_spot_market_request) | data source |
| [template_cloudinit_config.config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/cloudinit_config) | data source |
| [template_file.cloudconfig](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing-cycle"></a> [billing-cycle](#input\_billing-cycle) | n/a | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | n/a | `string` | n/a | yes |
| <a name="input_machine-size"></a> [machine-size](#input\_machine-size) | n/a | `string` | n/a | yes |
| <a name="input_max-bid"></a> [max-bid](#input\_max-bid) | n/a | `number` | n/a | yes |
| <a name="input_max-nodes"></a> [max-nodes](#input\_max-nodes) | n/a | `number` | n/a | yes |
| <a name="input_min-nodes"></a> [min-nodes](#input\_min-nodes) | n/a | `number` | n/a | yes |
| <a name="input_operating-system"></a> [operating-system](#input\_operating-system) | n/a | `string` | n/a | yes |
| <a name="input_project-name"></a> [project-name](#input\_project-name) | n/a | `string` | n/a | yes |
| <a name="input_spot-metro"></a> [spot-metro](#input\_spot-metro) | n/a | `string` | n/a | yes |
| <a name="input_user-data-file"></a> [user-data-file](#input\_user-data-file) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
<!-- END_TF_DOCS -->