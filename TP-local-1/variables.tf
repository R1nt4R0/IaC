variable "docker_image_name" {
  description = "Nom de l'image Docker"
  type        = string
  default     = "nginx:latest"
}

variable "container_name" {
  description = "Nom du conteneur nginx"
  type        = string
  default     = "nginx"
}

variable "external_port" {
  description = "Port externe exposé"
  type        = number
  default     = 8081
}

variable "internal_port" {
  description = "Port interne du conteneur"
  type        = number
  default     = 80
}

variable "client_count" {
  description = "Nombre de conteneurs client à créer"
  type        = number
  default     = 3
}

variable "servers" {
  description = "Liste des serveurs clients"
  type        = list(string)
  default     = ["alpha", "beta", "gamma"]
}

variable "machines" {
  description = "Liste des machines virtuelles à déployer"
  type = list(object({
    name      = string
    vcpu      = number
    disk_size = number
    region    = string
  }))

  default = [
    {
      name      = "vm-app-1"
      vcpu      = 2
      disk_size = 20
      region    = "eu-west-1"
    },
    {
      name      = "vm-db-1"
      vcpu      = 4
      disk_size = 50
      region    = "us-east-1"
    }
  ]

  validation {
    condition = alltrue([
      for m in var.machines : m.vcpu >= 2 && m.vcpu <= 64
    ])
    error_message = "Chaque machine doit avoir un nombre de vCPU compris entre 2 et 64."
  }

  validation {
    condition = alltrue([
      for m in var.machines : m.disk_size >= 20
    ])
    error_message = "Chaque machine doit avoir une taille de disque supérieure ou égale à 20 Go."
  }

  validation {
    condition = alltrue([
      for m in var.machines : contains(["eu-west-1", "us-east-1", "ap-southeast-1"], m.region)
    ])
    error_message = "Chaque machine doit utiliser une région valide parmi : eu-west-1, us-east-1, ap-southeast-1."
  }
}