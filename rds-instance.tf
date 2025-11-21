###############################
##### Database-subnet Group ###
###############################

resource "aws_db_subnet_group" "Database-subnet-Group" {
  name        = "database-subnet"
  subnet_ids  = [aws_subnet.private_db_subnet_1.id, aws_subnet.private_db_subnet_2.id]
  description = "Database subnet for Database to be in"

  tags = {
    name = "Database-Subnet"
  }
}


##############################
#### Database Instance #######
##############################


resource "aws_db_instance" "Mysqldb" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "Mysqldb"
  username               = "rawatjii"
  password               = "rawat2003"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  availability_zone      = "us-east-1b"
  db_subnet_group_name   = aws_db_subnet_group.Database-subnet-Group.name
  multi_az               = true
  vpc_security_group_ids = [aws_security_group.db_tier_sg.id]

}