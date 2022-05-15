output "private_key_pem" {
  description = "private_key_pem"
  value       = try(tls_private_key.dev_key.private_key_pem, "")
}
output "generated_key_name" {
  description = "generated_key_name"
  value       = var.generated_key_name
}
