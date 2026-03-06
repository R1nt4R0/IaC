terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.5.0"
    }
  }
}

provider "docker" {
  host = "tcp://localhost:2375"
}

resource "docker_network" "app_network" {
  name = "terraform-network"
}

resource "docker_image" "nginx" {
  name         = var.docker_image_name
  keep_locally = true
}

resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  networks_advanced {
    name = docker_network.app_network.name
  }
}

resource "docker_image" "client" {
  name         = "appropriate/curl:latest"
  keep_locally = true
}

resource "docker_container" "client" {

  for_each = toset(var.servers)

  name  = "server-${each.value}"
  image = docker_image.client.image_id

  command = [
    "sh",
    "-c",
    "curl http://nginx:80 && sleep 30"
  ]

  networks_advanced {
    name = docker_network.app_network.name
  }

  depends_on = [docker_container.nginx]
}