variable "creation_token" {
  type = string
  description = "unique identifier addd to efs"
}

variable "performance_mode" {
  type = string
  description = "can be one of the following: generalPurpose, maxIO"
  default = "generalPurpose"
}

variable "throughput_mode" {
  type = string
  description = "can be one of the following: bursting, provisioned, elastic"
  default = "bursting"
}

variable "provisioned_throughput_in_mibps" {
  type = number
  default = 0
}

variable "lifecycle_policy" {
  description = "lifecycle policy for files saved on efs"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "id of vpc to spin up efs in"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet ids to be used for EFS mount"
}

variable "incoming_security_groups" {
  type        = list(string)
  description = "security Groups to allow connections from"
}

variable "replication_region" {
  type = string
  default = ""
}