// Define a data source of type "aws_ami" with the name "ubuntu" to fetch the most recent Ubuntu AMI ID
// The filters specify that we want an AMI with a name that matches the pattern "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
// and that has a virtualization type of "hvm". The owner is set to "099720109477", which is the AWS account ID for Canonical, the publisher of Ubuntu AMIs

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
}
