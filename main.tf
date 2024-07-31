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

data "hcp_vault_secrets_app" "labyrinth" {
  app_name = "labyrinth"
}

resource "aws_db_instance" "labyrinth-db" {
  allocated_storage                     = 20
  db_subnet_group_name                  = data.terraform_remote_state.network.outputs.subnet_group_name
  engine                                = "mysql"
  engine_version                        = "8.0.35"
  identifier                            = "labyrinth-db"
  instance_class                        = "db.m6gd.large"
  parameter_group_name                  = "default.mysql8.0"
  password                              = data.hcp_vault_secrets_app.labyrinth.data["password"]
  publicly_accessible                   = false
  skip_final_snapshot                   = true
  username                              = data.hcp-vault-secrets_app.labyrinth.username
  vpc_security_group_ids                = data.terraform_remote_state.network.outputs.rds_security_group_id

  tags = {
    Name = "Labyrinth Database"
  }
}
