provider "hcp" {
}

provider "aws" {
  region = data.terraform_remote_state.network.outputs.region
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = var.tfc_org_name
    workspaces = {
      name = var.tfc_network_workspace_name
    }
  }
}

# Data block to retrieve the username from Vault Secrets
data "hcp_vault_secrets_secret" "username" {
  app_name    = var.hvs_app_name
  secret_name = var.username_secret
}

# Data block to retrieve the password from Vault Secrets
data "hcp_vault_secrets_secret" "password" {
  app_name    = var.hvs_app_name
  secret_name = var.password_secret
}

resource "aws_db_instance" "labyrinth-db" {
  allocated_storage                     = 20
  db_subnet_group_name                  = data.terraform_remote_state.network.outputs.subnet_group_name
  engine                                = "mysql"
  engine_version                        = "8.0.35"
  identifier                            = var.database
  instance_class                        = "db.m6gd.large"
  parameter_group_name                  = "default.mysql8.0"
  password                              = data.hcp_vault_secrets_secret.password.secret_value
  publicly_accessible                   = true
  skip_final_snapshot                   = true
  username                              = data.hcp_vault_secrets_secret.username.secret_value
  vpc_security_group_ids                = data.terraform_remote_state.network.outputs.rds_security_group_id

  tags = {
    Name = "Labyrinth Database"
  }
}
