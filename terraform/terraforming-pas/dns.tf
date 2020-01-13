variable "parent_dns_rg" {}

data "azurerm_dns_zone" "parent_zone" {
  name                = "${var.dns_suffix}"
  resource_group_name = "${var.parent_dns_rg}"
}

resource "azurerm_dns_ns_record" "pas_ns_record" {
  name                = "${var.env_name}"
  zone_name           = "${data.azurerm_dns_zone.parent_zone.name}"
  resource_group_name = "${var.parent_dns_rg}"
  ttl                 = 300

  records = ["${module.infra.dns_zone_name_servers}"]
}

# resource "azurerm_dns_a_record" "pas_api" {
#   name                = "api"
#   zone_name           = "${module.infra.dns_zone_name}"
#   resource_group_name = "${module.infra.resource_group_name}"
#   ttl                 = 300
#   records             = ["${module.pas.pas_lb_ip}"]
# }

