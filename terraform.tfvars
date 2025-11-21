################################
######### VPC File #############
################################




# VPC_CIDR Value 
vpc_cidr = "192.168.0.0/16"

# Public Subnet 1 CIDR
pub-subnet-1 = "192.168.1.0/24"

# Public Subnet 2 CIDR
pub-subnet-2 = "192.168.2.0/24"

# Private app-tier Subnet 1 CIDR
priv-app-subnet-1 = "192.168.3.0/24"

# Private app-tier Subnet 2 CIDR
priv-app-subnet-2 = "192.168.4.0/24"

# Private DB-tier Subnet 1 CIDR
priv-db-subnet-1 = "192.168.5.0/24"

# Private DB-tier Subnet 2 CIDR
priv-db-subnet-2 = "192.168.6.0/24"





################################
##### Scaling_G. File ##########       || web-tier
################################


# Web_tier Launch Template AMI ID for Auto Scaling Group 
web_template_ami = "ami-0ecb62995f68bb549" #Ubuntu Server 24.04 LTS


# Web_tier Launch Template Instance Type for Auto Scaling Group 
web_template_instance_type = "t2.micro"


# Key Pair Name for Launch Template in Auto Scaling Group
web_template_key_name = "terraform" # enter your key pair name here

# Deletion protection of Load balancer in the Web Tier
web-alb-deletion-protection = false




################################
##### Scaling_G. File ##########       || App-tier
################################


# App_tier Launch Template AMI ID for Auto Scaling Group 
app_template_ami = "ami-0ecb62995f68bb549" #Ubuntu Server 24.04 LTS


# App_tier Launch Template Instance Type for Auto Scaling Group 
app_template_instance_type = "t2.micro"


# Key Pair Name for Launch Template in Auto Scaling Group
app_template_key_name = "terraform" # enter your key pair name here


# Deletion protection of Load balancer in the Web Tier
app-alb-deletion-protection = false