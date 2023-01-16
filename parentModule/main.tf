terraform {
  required_providers {
    aws = {
      configuration_aliases = [aws, aws.v4]
    }
  }
}

// no replication so default aws provider ver 3.55
module "firstChild" {
  source = "./childModule"
  creation_token = "firstChild"
  performance_mode = var.performance_mode
  throughput_mode = var.throughput_mode
  lifecycle_policy = "AFTER_90_DAYS"
  vpc_id = var.vpc_id
  incoming_security_groups = var.incoming_security_groups
  subnet_ids = var.subnet_ids
  replication_enabled = true
  region = "us-west-2"
}

// efs replication so need the alias aws provider
module "secondChild" {
  source = "./childModule"
  creation_token = "secondChild"
  performance_mode = var.performance_mode
  throughput_mode = var.throughput_mode
  lifecycle_policy = "AFTER_90_DAYS"
  vpc_id = var.vpc_id
  incoming_security_groups = var.incoming_security_groups
  subnet_ids = var.subnet_ids
  replication_enabled = false
  replication_region = "us-west-2"
  provider = aws.v4
}