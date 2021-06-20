locals {
  tags_default = {
    team      = "infra"
    terraform = "true"
    env       = "test"
  }

  tags = merge(local.tags_default, var.tags)
}