# Terraform Production CI/CD

Production-style Terraform CI/CD using GitHub, Jenkins, Terraform and AWS.

## Flow

Developer
↓
GitHub
↓
Jenkins
↓
Terraform fmt
↓
Terraform init
↓
Terraform validate
↓
Terraform plan
↓
Plan Artifact
↓
Production Approval
↓
Terraform Apply
↓
AWS

## Terraform Structure

- environments/dev
- environments/prod
- modules/vpc
- modules/security-group
- modules/ec2

