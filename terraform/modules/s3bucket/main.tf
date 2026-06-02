resource "aws_s3_bucket" "vinayak_bucket" {
    bucket = var.bucket_name
    tags = { 
            Name        = "Vinayak S3 Bucket" 
            Environment = "Dev"
    }
}