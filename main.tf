// what do I need?
// performance mode
// throughput_mode
// provisioned_throughput_in_mibps
// vpc_id (thru data)
// incoming_security_groups
// subnet_ids
data "aws_vpc" "my_default_vpc" {
  id="insert your vpc id"
}

resource "aws_security_group" "my_efs_sg" {
  vpc_id=data.aws_vpc.my_default_vpc.id
  name="my_efs_sg"
}

resource "aws_subnet" "efs_subnet" {
  vpc_id=data.aws_vpc.my_default_vpc.id
  cidr_block = "172.16.2.0/24"
}


module "my_infra" {
  source = "./parentModule"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  
  vpc_id = data.aws_vpc.my_default_vpc.id
  incoming_security_groups = [aws_security_group.my_efs_sg]
  subnet_ids = [ aws_subnet.efs_subnet]
  providers ={
    aws = aws
    aws.v4 = aws.awsv416
  }
}

