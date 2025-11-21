variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}


######################################
##### Public Subnets || Web tier #####
######################################



variable "pub-subnet-1" {
  description = "Public Subnet 1 CIDR"
  type        = string
}


variable "pub-subnet-2" {
  description = "Public Subnet 2 CIDR"
  type        = string
}



###################
##### APP Tier ####
###################


variable "priv-app-subnet-1" {
  description = "Private_app_tier_Subnet 1 CIDR"
  type        = string
}

variable "priv-app-subnet-2" {
  description = "Private_app_tier_Subnet 2 CIDR"
  type        = string
}



##################
##### DB Tier ####
##################


variable "priv-db-subnet-1" {
  description = "Private_db_tier_Subnet 1 CIDR"
  type        = string
}

variable "priv-db-subnet-2" {
  description = "Private_db_tier_Subnet 2 CIDR"
  type        = string
}




##################################
###### web_Sclaing_G. File #######     || Web-Tier
##################################

variable "web_template_ami" {
  description = "launch template for the auto scaling Group and ALB"
  type        = string

}


variable "web_template_instance_type" {
  description = "instance type for the auto scaling Group and ALB"
  type        = string

}


variable "web_template_key_name" {
  description = "Key pair name for EC2 instances on Web Tier"
  type        = string
}


variable "web-alb-deletion-protection" {
  description = "Deletion Protection for the Web-load balancer"
  type        = bool
}






################################
###### App_Sclaing_G. File #####      || App-Tier
################################



variable "app_template_ami" {
  description = "launch template for the auto scaling Group and ALB"
  type        = string

}


variable "app_template_instance_type" {
  description = "instance type for the auto scaling Group and ALB"
  type        = string

}


variable "app_template_key_name" {
  description = "Key pair name for EC2 instances on App Tier"
  type        = string
}



variable "app-alb-deletion-protection" {
  description = "Deletion Protection for the App-load balancer"
  type        = bool
}