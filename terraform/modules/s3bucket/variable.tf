 variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
    default     = "vinayak-unique-bucket-name"  
 }
 variable "region" {
    description = "The AWS region to create resources in"
    type        = string
    default     = "us-west-1"
   
 }
 variable "environment" {
    description = "The environment for the resources (e.g., dev, prod)"
    type        = string
    default     = "dev"
 }