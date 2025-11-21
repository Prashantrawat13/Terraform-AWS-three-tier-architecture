##################################
######## Target Group ###########     || App-Tier
##################################


resource "aws_lb_target_group" "app_tier-alb-target-group" {
  name     = "app-tier-target-group"
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
    Name = "app-tier-target-group"
  }

}





######################################
####### Application Load Balancer ####    || App-Tier
######################################


resource "aws_lb" "app_tier-alb" {
  name               = "ALB-Internal"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_app_sg.id]
  subnets = [
    aws_subnet.private_app_subnet_1.id,
    aws_subnet.private_app_subnet_2.id
  ]

  enable_deletion_protection = var.app-alb-deletion-protection

  tags = {
    Name = "ALB-intenal"
  }
}





############################
####### Listener Port ######    || App-Tier
############################


resource "aws_lb_listener" "app_http_listener" {
  load_balancer_arn = aws_lb.app_tier-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tier-alb-target-group.arn
  }
}