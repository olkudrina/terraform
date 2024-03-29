provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "db" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    tags = {
        Name = "db server"
    }
}

resource "aws_instance" "web" {
    ami = "ami-032598fcc7e9d1c7a"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    user_data = file("server-script.sh")
    tags = {
        Name = "web server"
    }
}

resource "aws_eip" "web_ip" {
    instance = aws_instance.web.id
}

resource "aws_security_group" "webtraffic" {
    name = "sllow web traffic"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
            } 
    }

    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
            }
    }
}

output "PrivateIP" {
  value       = aws_instance.db.private_ip
}

output "PublicIP" {
  value       = aws_eip.web_ip.public_ip
}
