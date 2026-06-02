variable "cidr_block" {
    description = "The CIDR block for the subnet"
    type        = string
    default     = "10.0.1.0/24"
}
variable "vpc_id" {
    description = "The ID of the VPC to create the subnet in"
    type        = string
}

