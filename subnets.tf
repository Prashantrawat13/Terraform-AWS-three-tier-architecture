############################
# Public Subnet 1 | web_tier
############################
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub-subnet-1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_1 | web_tier"
  }
}


############################
# Public Subnet 2 | web_tier
############################
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.pub-subnet-2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_2 | web_tier"
  }
}


############################
# Private Subnet 1 | app_tier
############################
resource "aws_subnet" "private_app_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.priv-app-subnet-1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet_1 | app_tier"
  }
}


############################
# Private Subnet 2 | app_tier
############################
resource "aws_subnet" "private_app_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.priv-app-subnet-2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet_2 | app_tier"
  }
}

###########################
# Private Subnet 1 | db_tier
###########################
resource "aws_subnet" "private_db_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.priv-db-subnet-1
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet_1 | db_tier"
  }
}

###########################
# Private Subnet 2 | db_tier
###########################
resource "aws_subnet" "private_db_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.priv-db-subnet-2
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private_Subnet 2 | db_tier"
  }
}