##################################
######## Launch Template #########     || App-Tier
##################################

resource "aws_launch_template" "app_tier-ec2-launch_template" {
  description   = "Launch template for app tier EC2 instances"
  name_prefix   = "App_template"
  image_id      = var.app_template_ami
  instance_type = var.app_template_instance_type
  key_name      = var.app_template_key_name

  user_data = filebase64("${path.module}/user-data/app-script.sh")


  network_interfaces {
    security_groups             = [aws_security_group.app_tier_sg.id]
    associate_public_ip_address = false
  }

  tags = {
    Name = "app_tier-ec2-launch_template"
  }
}




#####################################
######## Auto Scaling Group #########     || App-Tier
#####################################




resource "aws_autoscaling_group" "app_tier_asg" {
  desired_capacity = 2
  max_size         = 4
  min_size         = 1
  vpc_zone_identifier = [
    aws_subnet.private_app_subnet_1.id,
    aws_subnet.private_app_subnet_2.id
  ]
  launch_template {
    id      = aws_launch_template.app_tier-ec2-launch_template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.app_tier-alb-target-group.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "app-tier-ec2-instance"
    propagate_at_launch = true
  }
}