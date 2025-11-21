##################################
######## Launch Template #########     || Web-Tier
##################################

resource "aws_launch_template" "web_tier-ec2-launch_template" {
  description   = "Launch template for Web tier EC2 instances"
  name_prefix   = "Web_template"
  image_id      = var.web_template_ami
  instance_type = var.web_template_instance_type
  key_name      = var.web_template_key_name

  user_data = filebase64("${path.module}/user-data/web-script.sh")


  network_interfaces {
    security_groups             = [aws_security_group.web_tier_sg.id]
    associate_public_ip_address = true
  }

  tags = {
    Name = "Web_tier-ec2-launch_template"
  }
}




#####################################
######## Auto Scaling Group #########     || Web-Tier
#####################################




resource "aws_autoscaling_group" "web_tier_asg" {
  desired_capacity = 2
  max_size         = 4
  min_size         = 1
  vpc_zone_identifier = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  launch_template {
    id      = aws_launch_template.web_tier-ec2-launch_template.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb_target_group.web_tier-alb-target-group.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "web-tier-ec2-instance"
    propagate_at_launch = true
  }
}