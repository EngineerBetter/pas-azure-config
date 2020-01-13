output "infrastructure_subnet_reserved" {
  value = "${cidrhost(module.infra.infrastructure_subnet_cidr, 1)}-${cidrhost(module.infra.infrastructure_subnet_cidr, 9)}"
}

output "services_subnet_reserved" {
  value = "${cidrhost(module.pas.services_subnet_cidr, 1)}-${cidrhost(module.pas.services_subnet_cidr, 9)}"
}

output "pas_subnet_reserved" {
  value = "${cidrhost(module.pas.pas_subnet_cidr, 1)}-${cidrhost(module.pas.pas_subnet_cidr, 9)}"
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
