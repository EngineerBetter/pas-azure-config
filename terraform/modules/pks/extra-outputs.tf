output "pks_lb_name" {
  value = "${var.env_id}-pks-lb"
}

output "pks_lb_ip" {
  value = "${azurerm_public_ip.pks-lb-ip.ip_address}"
}
