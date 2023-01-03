terraform {
  required_providers {
    equinix = {
      source  = "equinix/equinix"
      version = "~>1.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.3.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>3.4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0.7.2"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~>2.2.0"
    }
  }
}


provider "tls" {
}

provider "random" {
}

provider "time" {
}

provider "cloudinit" {
}

# Credentials for all Equinix resources
provider "equinix" {
  auth_token = ""
}
