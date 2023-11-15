data "sops_file" "secrets" {
  source_file = "secrets.yaml"
}

locals {
  secrets = yamldecode(data.sops_file.secrets.raw)
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = local.secrets.aws.access_key
  secret_key = local.secrets.aws.secret_key
}

provider "hcloud" {
  token = local.secrets.hcloud.hcloud_token
}

provider "cloudflare" {
  api_token = local.secrets.cloudflare.api_token
}

provider "hydra" {
  host     = local.secrets.hydra.host
  username = "terraform"
  password = local.secrets.hydra.password
}


