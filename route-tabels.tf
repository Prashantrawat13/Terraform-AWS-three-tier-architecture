###############################
# Public Route Tables Creation and IGW attach
################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "Public_Route_Table"
  }
}


###############################
# Associating Public subnet to Public Route Table
###############################
resource "aws_route_table_association" "public_rt_web_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "public_rt_web_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}







###################################
# Private Route Tables Creation and Nat-GW attach
###################################
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }

  tags = {
    Name = "Private_Route_Table"
  }
}






##############################
# Associating APP subnet to private Route Table
##############################
resource "aws_route_table_association" "pvt_nat_route_app_1" {
  subnet_id      = aws_subnet.private_app_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "pvt_nat_route_app_2" {
  subnet_id      = aws_subnet.private_app_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}



################################
# Associating DB subnet to private Route Table
################################
resource "aws_route_table_association" "pvt_nat_route_db_1" {
  subnet_id      = aws_subnet.private_db_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}


resource "aws_route_table_association" "pvt_nat_route_db_2" {
  subnet_id      = aws_subnet.private_db_subnet_2.id
  route_table_id = aws_route_table.private_rt.id
}