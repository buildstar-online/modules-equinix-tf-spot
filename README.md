# Usage

```bash
docker pull hashicorp/terraform:latest && \
    docker run --platform linux/amd64 -it \
    -v $(pwd):/workspace \
    -w /workspace \
    hashicorp/terraform:latest apply -target equinix_metal_spot_market_request.req

docker pull hashicorp/terraform:latest && \
    docker run --platform linux/amd64 -it \
    -v $(pwd):/workspace \
    -w /workspace \
    hashicorp/terraform:latest apply

docker pull hashicorp/terraform:latest && \
    docker run --platform linux/amd64 -it \
    -v $(pwd):/workspace \
    -w /workspace \
    hashicorp/terraform:latest destroy -target equinix_metal_spot_market_request.req
```
