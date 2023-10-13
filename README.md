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

## Bidding Strategies

While your specific bidding strategy is entirely up to you, most users adopt one of these bidding strategies based on their use case:

1. Strictly Optimize Cost - Sacrifice availability for the deepest discount. This is great for long-running workloads that have flexible end dates.
    - Use Case: Research-style tasks
    - Suggested Bid: near minimum

2. Cost/Availability Balance - Slightly higher price than strictly cost optimized, but allows you to increase the likelihood of getting and keeping an instance for longer periods of time.
    - Use Case: Batch jobs that can handle some amount of reclamation
    - Suggested Bid: 10-20% above minimum

3. Bid On Demand Price - Receive a discount anytime the spot price is lower than on demand, immediately switching to on demand when it goes higher.
    - Use Case: Fully cloud native applications capable of easily moving workloads around
    - Suggested Bid: on demand price

4. Optimize Continuity - Bid very high to ensure availability and continuity.
    - Use Case: Accept some periods of higher-than-market prices in return for uptime continuity
    - Suggested Bid: 2x-3x on demand price

## Prices and Inventory in Amsterdam

Machine Sizes: https://deploy.equinix.com/product/bare-metal/servers/

Current spot prices:

```bash
TOKEN=$(bw get notes equinix-api-token) && \
URL="https://api.equinix.com/metal/v1/market/spot/prices/metros" && \
METRO="am" && \
PRICES=$(curl -X GET -H "X-Auth-Token: $TOKEN" $URL -d "metro=$METRO" | \
python3 -c "import sys, json; print(json.load(sys.stdin)['spot_market_prices']['am'])"| sed "s/'/\"/g") && \
echo $PRICES |jq
```

```json
{
  "a3.large.x86": {
    "price": 0.75
  },
  "c2.medium.x86": {
    "price": 2.01
  },
  "c3.medium.x86": {
    "price": 2.21
  },
  "c3.small.x86": {
    "price": 1.01
  },
  "m2.xlarge.x86": {
    "price": 4.01
  },
  "m3.large.x86": {
    "price": 0.68
  },
  "m3.small.x86": {
    "price": 0.11
  },
  "n2.xlarge.x86": {
    "price": 1.0
  },
  "n3.xlarge.x86": {
    "price": 0.45
  },
  "s3.xlarge.x86": {
    "price": 0.61
  },
  "t3.small.x86": {
    "price": 0.71
  },
  "t3.xsmall.x86": {
    "price": 0.71
  }
}
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
