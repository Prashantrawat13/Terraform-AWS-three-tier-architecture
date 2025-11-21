# Here we'll Create the Security Group 
# We'll make 5 Security Groups
# 1 For the ALB in Public Web Tier
# 1 For the Public Web Tier Instance
# 1 For the ALB in Private App Tier
# 1 For the Private App Tier Instance
# 1 For the Private DB Tier {RDS}


##########################################
### Security Group for ALB Web Tier ###
##########################################
resource "aws_security_group" "alb_sg" {
  name        = "ALB_SG"
  description = "Security Group for ALB in Public Web Tier"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      description = "For ALB Web Tier Inbound Traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Web_ALB_SG"
  }
}



################################################
### Security G. for Public Web Tier Instance ###
################################################
resource "aws_security_group" "web_tier_sg" {
  name        = "Web_Tier_SG"
  description = "Security Group for Public Web Tier Instance"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Allow inbound traffic from ALB"
      security_groups = [aws_security_group.alb_sg.id]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.49.181.232/32"]
    description = "Allow SSH from my IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "Web_Tier_SG"
  }
}





#############################################
##### Security G. for ALB App Tier ##########
#############################################
resource "aws_security_group" "alb_app_sg" {
  name        = "ALB_App_SG"
  description = "Security Group for ALB in Private App Tier"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = [80, 443, 8080]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "For ALB Private App Tier Inbound Traffic"
      security_groups = [aws_security_group.web_tier_sg.id]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "App_ALB_SG"
  }
}




################################################
### Security G. for Private App Tier Instance ##
################################################
resource "aws_security_group" "app_tier_sg" {
  name        = "App_Tier_SG"
  description = "Security Group for Private App Tier Instance"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = [8080, 80, 443]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Allow inbound traffic from ALB"
      security_groups = [aws_security_group.alb_app_sg.id]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.49.181.232/32"]
    description = "Allow SSH from my IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
  tags = {
    Name = "App_Tier_SG"
  }
}




################################################
### Security G. for Private DB Tier (RDS) ######
################################################
resource "aws_security_group" "db_tier_sg" {
  name        = "DB_Tier_SG"
  description = "Security Group for Private DB Tier RDS Instance"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description     = "Allow MYSQL traffic from App Tier-SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_tier_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["157.49.181.232/32"]
    description = "Allow SSH from my IP"
  }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  #   description = "Allow all outbound traffic"
  # }
  tags = {
    Name = "DB_Tier_SG"
  }
}