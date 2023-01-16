resource "aws_efs_file_system" "efs_fs" {
  creation_token = var.creation_token
  performance_mode = var.performance_mode
  throughput_mode = var.throughput_mode

  lifecycle_policy {
    transition_to_ia = var.lifecycle_policy
  }
}

resource "aws_security_group" "efs_sg" {
  name = "efs_security_group"
  vpc_id = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "ingress_rules_from_sg" {
  count = length(var.incoming_security_groups)
  type = "ingress"
  from_port = "2049"
  to_port = "2049"
  protocol = "tcp"
  source_security_group_id = var.incoming_security_groups[count.index]
  security_group_id = aws_security_group.efs_sg.id
}

resource "aws_efs_mount_target" "efs_fs_mount" {
  count = length(var.subnet_ids)
  file_system_id = aws_efs_file_system.efs_fs.id
  subnet_id = var.subnet_ids[count.index]
  security_groups = [aws_security_group.efs_sg]
}

resource "aws_efs_replication_configuration" "efs_fs_replication_config" {
  count = var.replication_enabled ? 1 : 0
  source_file_system_id = aws_efs_file_system.efs_fs.id
  destination = {
    region = var.replication_region
  }
}