variable "tfc_org_name" {
  description = "Name of the Terraform Cloud Organization"
  type        = string
  default     = "se-intern-project"
}

variable "tfc_network_workspace_name" {
  description = "Name of the network workspace"
  type        = string
}

variable "hvs_app_name" {
  description = "Name of HVS app"
  default     = "labyrinth"
}

variable "username_secret" {
  description = "Name of the secret"
  default     = "username"
}

variable "password_secret" {
  description = "Name of the secret"
  default     = "password"
}

variable "database" {
  description = "Identifier of the db"
  default     = "labyrinth-db"
}
