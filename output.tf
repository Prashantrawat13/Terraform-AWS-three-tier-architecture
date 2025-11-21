# output "ec2_publi_IP" {
#   value       = aws_instance.
#   description = "Public IP of Web Tier EC2 Instance"
# }

output "Enternal_load_balancer" {
  value       = aws_lb.web_tier-alb.dns_name
  description = "DNS Name of Web Tier Load Balancer"
}


output "internal_load_balancer" {
  value       = aws_lb.app_tier-alb.dns_name
  description = "DNS Name of App Tier Load Balancer"
}