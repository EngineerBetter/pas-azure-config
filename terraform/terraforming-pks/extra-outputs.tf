output "infrastructure_subnet_reserved" {
  value = "${cidrhost(module.infra.infrastructure_subnet_cidr, 1)}-${cidrhost(module.infra.infrastructure_subnet_cidr, 9)}"
}

output "services_subnet_reserved" {
  value = "${cidrhost(module.pks.services_subnet_cidr, 1)}-${cidrhost(module.pks.services_subnet_cidr, 9)}"
}

output "pks_subnet_reserved" {
  value = "${cidrhost(module.pks.pks_subnet_cidr, 1)}-${cidrhost(module.pks.pks_subnet_cidr, 9)}"
}

output "location" {
  value = "${var.location}"
}

output "dns_suffix" {
  value = "${var.dns_suffix}"
}

output "env_name" {
  value = "${var.env_name}"
}

output "pks_lb_name" {
  value = "${module.pks.pks_lb_name}"
}

output "pks_ip" {
  value = "${module.pks.pks_lb_ip}"
}
