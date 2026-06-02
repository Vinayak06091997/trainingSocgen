resource "aws_subnet" "vinayak_subnet" {
    vpc_id     = var.vpc_id
    cidr_block = var.cidr_block
}