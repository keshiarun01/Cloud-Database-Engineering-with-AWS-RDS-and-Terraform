terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# SECURITY GROUP FOR RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL access only from my IP"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # YOUR IP ONLY
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# SUBNET GROUP (REQUIRED BY RDS)
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

# RDS INSTANCE (FREE-TIER ELIGIBLE)
resource "aws_db_instance" "mysql_db" {
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  identifier              = "resume-demo-db"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  skip_final_snapshot     = true
  publicly_accessible     = true

  backup_retention_period = 1

  tags = {
    Name = "ResumeRDSProject"
  }
}
