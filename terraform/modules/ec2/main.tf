
resource "aws_instance" "vinayak_ec2" {
    depends_on = [aws_s3_bucket.vinayak_bucket, aws_subnet.vinayak_subnet]  # Ensure the S3 bucket and subnet are created before the EC2 instance
    ami           = data.aws_ami.ubuntu.id     # Ubuntu AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"                 # Free tier eligible instance type
    subnet_id     = aws_subnet.vinayak_subnet.id # Place the EC2 instance in the created subnet
    tags = aws_s3_bucket.vinayak_bucket.tags   # Reuse tags from the S3 bucket
}