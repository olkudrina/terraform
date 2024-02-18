provider "aws" {
    region = "eu-west-1"
}

resource "aws_vpc" "testvpc" {
    cidr_block = "192.168.0.0/24"
    tags = {
        Name = "TerraformVPC"
    }
}