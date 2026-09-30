resource "aws_vpc" "primary-vpc" {
  provider             = aws.primary-region
  cidr_block           = var.primary-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "primary-vpc-${var.primary-region}"
    Purpose = "VPC-Peering-Demo"
  }
}

resource "aws_vpc" "secondary-vpc" {
  provider             = aws.secondary-region
  cidr_block           = var.secondary-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "secondary-vpc-${var.secondary-region}"
    Purpose = "VPC-Peering-Demo"
  }
}

resource "aws_subnet" "primary-subnet" {
  provider                = aws.primary-region
  vpc_id                  = aws_vpc.primary-vpc.id
  cidr_block              = var.primary-subnet-cidr
  availability_zone       = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "Primary-Subnet-${var.primary-region}"
    Environment = "Demo"
  }
}

resource "aws_subnet" "secondary-subnet" {
  provider                = aws.secondary-region
  vpc_id                  = aws_vpc.secondary-vpc.id
  cidr_block              = var.secondary-subnet-cidr
  availability_zone       = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "secondary-Subnet-${var.secondary-region}"
    Environment = "Demo"
  }
}

resource "aws_internet_gateway" "primary-igw" {
  provider = aws.primary-region
  vpc_id   = aws_vpc.primary-vpc.id

  tags = {
    Name        = "Primary-IGW"
    Environment = "Demo"
  }
}

resource "aws_internet_gateway" "secondary-igw" {
  provider = aws.secondary-region
  vpc_id   = aws_vpc.secondary-vpc.id

  tags = {
    Name        = "secondary-IGW"
    Environment = "Demo"
  }
}

resource "aws_route_table" "primary-rt" {
  provider = aws.primary-region
  vpc_id   = aws_vpc.primary-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary-igw.id
  }

  tags = {
    Name        = "Primary-Route-Table"
    Environment = "Demo"
  }
}

resource "aws_route_table" "secondary-rt" {
  provider = aws.secondary-region
  vpc_id   = aws_vpc.secondary-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.secondary-igw.id
  }

  tags = {
    Name        = "Secondary-Route-Table"
    Environment = "Demo"
  }
}

resource "aws_route_table_association" "primary-rta" {
  provider       = aws.primary-region
  subnet_id      = aws_subnet.primary-subnet.id
  route_table_id = aws_route_table.primary-rt.id
}

resource "aws_route_table_association" "secondary-rta" {
  provider       = aws.secondary-region
  subnet_id      = aws_subnet.secondary-subnet.id
  route_table_id = aws_route_table.secondary-rt.id
}

resource "aws_vpc_peering_connection" "primary-to-secondary" {
  provider    = aws.primary-region
  vpc_id      = aws_vpc.primary-vpc.id
  peer_vpc_id = aws_vpc.secondary-vpc.id
  peer_region = var.secondary-region
  auto_accept = false

  tags = {
    Name        = "Primary-to-Secondary-Peering"
    Environment = "Demo"
    Side        = "Requester"
  }
}

resource "aws_vpc_peering_connection_accepter" "secondary-to-primary" {
  provider                  = aws.secondary-region
  vpc_peering_connection_id = aws_vpc_peering_connection.primary-to-secondary.id

  tags = {
    Name        = "Secondary-Peering-Accepter"
    Environment = "Demo"
    Side        = "Accepter"
  }
}

resource "aws_route" "primary-to-secondary" {
  provider                  = aws.primary-region
  route_table_id            = aws_route_table.primary-rt.id
  destination_cidr_block    = var.secondary-cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary-to-secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary-to-primary]
}

resource "aws_route" "secondary-to-primary" {
  provider                  = aws.secondary-region
  route_table_id            = aws_route_table.secondary-rt.id
  destination_cidr_block    = var.primary-cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.primary-to-secondary.id

  depends_on = [aws_vpc_peering_connection_accepter.secondary-to-primary]
}

resource "aws_security_group" "primary_sg" {
  provider    = aws.primary-region
  name        = "primary-vpc-sg"
  description = "Security group for Primary VPC instance"
  vpc_id      = aws_vpc.primary-vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Secondary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.secondary-cidr]
  }

  ingress {
    description = "All traffic from Secondary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.secondary-cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Primary-VPC-SG"
    Environment = "Demo"
  }
}

resource "aws_security_group" "secondary_sg" {
  provider    = aws.secondary-region
  name        = "secondary-vpc-sg"
  description = "Security group for Secondary VPC instance"
  vpc_id      = aws_vpc.secondary-vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.primary-cidr]
  }

  ingress {
    description = "All traffic from Primary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.primary-cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Secondary-VPC-SG"
    Environment = "Demo"
  }
}

resource "aws_instance" "primary_instance" {
  provider               = aws.primary-region
  ami                    = data.aws_ami.primary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.primary-subnet.id
  vpc_security_group_ids = [aws_security_group.primary_sg.id]
  key_name               = var.primary_key_name

  user_data = local.primary_user_data

  tags = {
    Name        = "Primary-VPC-Instance"
    Environment = "Demo"
    Region      = var.primary-region
  }

  depends_on = [aws_vpc_peering_connection_accepter.secondary-to-primary]
}

resource "aws_instance" "secondary_instance" {
  provider               = aws.secondary-region
  ami                    = data.aws_ami.secondary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.secondary-subnet.id
  vpc_security_group_ids = [aws_security_group.secondary_sg.id]
  key_name               = var.secondary_key_name

  user_data = local.secondary_user_data

  tags = {
    Name        = "Secondary-VPC-Instance"
    Environment = "Demo"
    Region      = var.secondary-region
  }

  depends_on = [aws_vpc_peering_connection_accepter.secondary-to-primary]
}

