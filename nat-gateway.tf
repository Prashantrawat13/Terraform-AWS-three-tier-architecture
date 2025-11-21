################################
# Elastic IP for Nat Gateway
################################
resource "aws_eip" "nat_eip" {


  tags = {
    Name = "Nat_EIP"
  }
}

###################################
# Nat-GW Creation in Public Subnet 1
###################################
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "My_Nat_Gateway"
  }
}