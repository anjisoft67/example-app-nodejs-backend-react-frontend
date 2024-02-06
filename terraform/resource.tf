# Create a VPC
resource "aws_vpc" "VPC" {
  cidr_block = "10.10.0.0/16"

  tags = {
    "Name" = "VPC"
  }
}

# Create a public subnet
resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "public-subnet"
  }
  depends_on = [
    aws_vpc.VPC

  ]
}

# Create a private subnet
resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-subnet"
  }
  depends_on = [
    aws_vpc.VPC

  ]
}

# Create a internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "gw"
  }
}
# Create route table for public
resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
   # Create route table to public association
  resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.route-public.id
  }
  # Create route table for private
  resource "aws_route_table" "route-private" {
    vpc_id = aws_vpc.VPC.id
  }

  # Create route table to private association
  resource "aws_route_table_association" "b" {
    subnet_id      = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.route-private.id
  }
  # Create security group
  resource "aws_security_group" "allow_all" {
    name        = "allow_tls"
    description = "Allow TLS inbound traffic"
    vpc_id      = aws_vpc.VPC.id

    ingress {
      description = "SSH from VPC"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
     
    }
    ingress {
      description = "HTTPS from VPC"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      
    }

    ingress {
      description = "HTTP from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    
    }

    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  
    }

    tags = { 
      Name = "allow_all"
    }
  }

# Create key pair
resource "aws_key_pair" "keypair" {
  key_name   = "keypair"
  public_key = file("C:/Users/Chinna/.ssh/id_rsa.pub")

  tags = {
    "Name" = "keypair"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-08c40ec9ead489470" # ap-south-1
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  subnet_id = aws_subnet.public-subnet.id
  associate_public_ip_address = "true"
  key_name = "keypair"

  tags = {
    Name = "jenkins"
  }
}

