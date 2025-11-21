##################################
######## Target Group ###########     || Web-Tier
##################################


resource "aws_lb_target_group" "web_tier-alb-target-group" {
  name     = "web-tier-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "web-tier-target-group"
  }

}





######################################
####### Application Load Balancer ####    || Web-Tier
######################################


resource "aws_lb" "web_tier-alb" {
  name               = "external-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

  enable_deletion_protection = var.web-alb-deletion-protection

  tags = {
    Name = "external-alb"
  }
}





############################
####### Listener Port ######    || Web-Tier
############################


resource "aws_lb_listener" "web_http_listener" {
  load_balancer_arn = aws_lb.web_tier-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tier-alb-target-group.arn
  }
}