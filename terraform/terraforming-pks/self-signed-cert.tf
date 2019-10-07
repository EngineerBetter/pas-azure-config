variable "domains" {
  type = "list"
}

resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "tls_cert" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.tls_private_key.private_key_pem}"

  subject {
    common_name = "${element(var.domains, 0)}"
  }

  dns_names = "${var.domains}"

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

output "tls_private_key" {
  value = "${tls_private_key.tls_private_key.private_key_pem}"
}

output "tls_cert" {
  value = "${tls_self_signed_cert.tls_cert.cert_pem}"
}
