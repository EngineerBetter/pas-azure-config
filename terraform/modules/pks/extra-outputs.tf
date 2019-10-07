output "pks_lb_name" {
  value = "${var.env_id}-pks-lb"
}

output "pks_lb_ip" {
  value = "${azurerm_lb.pks-lb.private_ip_address}"
}
