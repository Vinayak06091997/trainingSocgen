variable "bucket_name" {
    description = "The name of the S3 bucket to create. Must be globally unique."
    type        = string
    default     = "vinayak-unique-bucket-name"
}

variable "instance_type" {
    description = "The type of EC2 instance to create."
    type        = string
    default     = "t2.micro"
}

variable "region" {
    description = "The AWS region where resources will be created."
    type        = string
    default     = "us-west-1"
}

variable "environment" {
    description = "The environment for the resources (e.g., dev, prod)."
    type        = string
    default     = "dev"
}

variable "cidr_block" {
    description = "The CIDR block for the VPC and default subnets"
    type        = string
    default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
    default     = "10.0.1.0/24"
}