provider "aws" {
  region = "us-east-1"
}

data "aws_subnet" "private1" {
  filter {
    name   = "tag:Name"
    values = ["ecs-private1"]
  }
}

data "aws_subnet" "private2" {
  filter {
    name   = "tag:Name"
    values = ["ecs-private2"]
  }
}

data "aws_security_group" "sg" {
  filter {
    name   = "tag:Name"
    values = ["lb-sg"]
  }
}

resource "aws_db_subnet_group" "sub-grp" {
  name       = "rds-subnet-group"
  subnet_ids = [data.aws_subnet.private1.id, data.aws_subnet.private2.id]

  tags = {
    Name = "My-DB-subnet-group"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  identifier             = "book-rds"
  engine                 = "mysql"
  engine_version         = "8.0.44"
  instance_class         = "db.t3.micro"
  multi_az               = true
  db_name                = "mydb"
  username               = "admin"
  password               = "samir123"
  db_subnet_group_name   = aws_db_subnet_group.sub-grp.name
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
  backup_retention_period = 0

  depends_on = [
    aws_db_subnet_group.sub-grp
  ]

  tags = {
    DB_identifier = "book-rds"
  }
}

output "rds_address" {
  value = aws_db_instance.rds.address
}
