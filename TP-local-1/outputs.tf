output "client_container_ids" {
  description = "IDs des conteneurs clients"
  value       = [for c in docker_container.client : c.id]
}

output "nginx_container_id" {
  description = "ID du container nginx"
  value       = docker_container.nginx.id
}