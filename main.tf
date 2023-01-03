# VPC, Security Group, ec2

# Resource-1: Create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-dev"
  }
}


# Create Security Group - SSH Traffic
resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type[1]
  count                  = var.ec2_instance_count

  vpc_security_group_ids = [aws_security_group.vpc-ssh.id]
  tags = {
    "Name" = "myec2vm"
  }
}
