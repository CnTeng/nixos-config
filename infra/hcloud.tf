locals {
  rxhc = {
    rxhc0 = {
      plan   = "cax21"
      region = "fsn1-dc14"
    }
  }
}

module "hcloud" {
  source   = "./modules/hcloud"
  for_each = local.rxhc
  hostname = each.key
  plan     = each.value.plan
  region   = each.value.region
}

module "hcloud_cf" {
  source   = "./modules/cloudflare"
  for_each = module.hcloud
  zone_id  = local.secrets.cloudflare.zone_id
  name     = each.key
  value    = each.value.ipv4
  proxied  = false
}

output "rxhc" {
  value = module.hcloud
}