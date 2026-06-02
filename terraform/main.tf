

// Create an S3 bucket to store files 
// Note: The bucket name must be globally unique across all AWS accounts
// Replace "vinayak-unique-bucket-name" with a unique bucket name of your choice
// acl = "private" means that the bucket will not be publicly accessible
# Define a resource of type "aws_s3_bucket" with the name "my_bucket" and my_bucket is a local name for this resource that can be used to reference it in other parts of the configuration

// Configure the AWS provider
# provider "aws" {
#     region = "us-west-1"
# }
# resource "aws_s3_bucket" "vinayak_bucket" {
#     count = 3 
#     bucket = count.index==1?"vinayak-unique-bucket-name-1":"vinayak-unique-bucket-name-${count.index}"
#     tags = { 
#             Name        = "Vinayak S3 Bucket" 
#             Environment = "Dev"
#     }
# }


# terraform {
#     backend "s3" {
#         bucket = "vinayak-unique-bucket-name"
#         key    = "terraform.tfstate"
#         region = "us-west-1"
#     }
# }


module "s3_bucket" {
    source      = "./modules/s3bucket"
    bucket_name = var.bucket_name
    region      = var.region
    environment = var.environment
}

module "vpc" {
    source     = "./modules/vpc"
    cidr_block = var.cidr_block
}

module "subnet" {
    depends_on = [module.vpc]
    source     = "./modules/subnet"
    cidr_block = var.cidr_block
    vpc_id     = module.vpc.vpc_id
}

