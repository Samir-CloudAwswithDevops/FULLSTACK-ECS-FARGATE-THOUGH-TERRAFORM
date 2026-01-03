provider "aws" {
  region = "us-east-1"   # MUST match infra region
}

# VPC
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["ecs-vpc"]
  }
}

# Private Subnet 1
data "aws_subnet" "private1" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["ecs-private1"]
  }
}

# Private Subnet 2
data "aws_subnet" "private2" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["ecs-private2"]
  }
}

# Public Subnet 1
data "aws_subnet" "public1" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["ecs-public1"]
  }
}

# Public Subnet 2
data "aws_subnet" "public2" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["ecs-public2"]
  }
}

# Security Group
data "aws_security_group" "sg" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["lb-sg"]
  }
}
