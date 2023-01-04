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

