variable "parent_dns_rg" {}

data "azurerm_dns_zone" "parent_zone" {
  name                = "${var.dns_suffix}"
  resource_group_name = "${var.parent_dns_rg}"
}

resource "azurerm_dns_ns_record" "pks_ns_record" {
  name                = "${var.env_name}"
  zone_name           = "${data.azurerm_dns_zone.parent_zone.name}"
  resource_group_name = "${var.parent_dns_rg}"
  ttl                 = 300

  records = ["${module.infra.dns_zone_name_servers}"]
}
