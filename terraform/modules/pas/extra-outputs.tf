output "pas_lb_name" {
  value = "${var.env_id}-pas-lb"
}

output "pas_lb_ip" {
  value = "${azurerm_public_ip.pas-lb-ip.ip_address}"
}
