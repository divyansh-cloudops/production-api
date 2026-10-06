terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecs_cluster" "production_api" {
  name = "production-api-cluster"

  lifecycle {
    ignore_changes = [
      configuration
    ]
  }
}

resource "aws_ecs_service" "production_api" {
  name    = "production-api-service"
  cluster = aws_ecs_cluster.production_api.id

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      capacity_provider_strategy,
      network_configuration,
      enable_ecs_managed_tags,
      deployment_circuit_breaker
    ]
  }
}

resource "aws_ecr_repository" "production_api" {
  name = "production-api"
}

resource "aws_security_group" "production_api" {
  name = "production-api-sg"

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  lifecycle {
    ignore_changes = [
      assume_role_policy
    ]
  }
}

resource "aws_rds_cluster" "production_db" {
  cluster_identifier = "database-1"
  engine             = "aurora-postgresql"

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_security_group" "production_api_db" {
  name = "production-api-db-sg"

  lifecycle {
    ignore_changes = all
  }
}