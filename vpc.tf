resource "aws_vpc" "vpc_aula01" {
  cidr_block            = var.vpcBlockIP
  instance_tenancy      =   "default"
  enable_dns_support    =   true
  enable_dns_hostnames  =   true

  tags                  = var.tags
}

resource "aws_internet_gateway" "igw_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  tags   = var.tags
}

resource "aws_nat_gateway" "nat_aula01" {
  allocation_id = aws_eip.eip_nat_aula01.id
  subnet_id     = aws_subnet.subpub1a.id

  tags = var.tags

  depends_on = [aws_internet_gateway.igw_aula01]
}

resource "aws_eip" "eip_nat_aula01" {
  vpc      = true
}

resource "aws_route_table" "rtb_pub_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_aula01.id
      }  

  tags = var.tags
}

resource "aws_route_table" "rtb_priv_aula01" {
  vpc_id = aws_vpc.vpc_aula01.id

  route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_aula01.id
      }  

  tags = var.tags
}

resource "aws_subnet" "subpriv1a" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = var.subnetPriv1BlockIP
  availability_zone_id     = data.aws_availability_zones.az1a.zone_ids[0]

  tags = var.tags
}

resource "aws_subnet" "subpriv1b" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = var.subnetPriv2BlockIP
  availability_zone_id     = data.aws_availability_zones.az1b.zone_ids[0]

  tags = var.tags
}
resource "aws_subnet" "subpub1a" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = var.subnetPub1BlockIP
  availability_zone_id     = data.aws_availability_zones.az1a.zone_ids[0]

  tags = var.tags
}
resource "aws_subnet" "subpub1b" {
  vpc_id                = aws_vpc.vpc_aula01.id
  cidr_block            = var.subnetPub2BlockIP
  availability_zone_id     = data.aws_availability_zones.az1b.zone_ids[0]

  tags = var.tags
}

resource "aws_route_table_association" "pub1a_aula01" {
  subnet_id      = aws_subnet.subpub1a.id
  route_table_id = aws_route_table.rtb_pub_aula01.id
}

resource "aws_route_table_association" "pub1b_aula01" {
  subnet_id      = aws_subnet.subpub1b.id
  route_table_id = aws_route_table.rtb_pub_aula01.id
}

resource "aws_route_table_association" "priv1a_aula01" {
  subnet_id      = aws_subnet.subpriv1a.id
  route_table_id = aws_route_table.rtb_priv_aula01.id
}

resource "aws_route_table_association" "priv1b_aula01" {
  subnet_id      = aws_subnet.subpriv1b.id
  route_table_id = aws_route_table.rtb_priv_aula01.id
}

resource "aws_security_group" "jenkins_web" {
  name        = "jenkins_web"
  description = "jenkins_web"
  vpc_id      = aws_vpc.vpc_aula01.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "Jenkins Port"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags               = var.tags
}
