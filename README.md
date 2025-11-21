# 🚀 Three-Tier AWS Infrastructure Using Terraform
A production-ready **Three-Tier Architecture** deployed on **AWS** using **Terraform**, featuring a fully scalable and secure environment with separate **Web**, **Application**, and **Database** tiers.

This README provides an appealing, GitHub-ready overview of the architecture, resources, and deployment flow.

---

## 📘 **Architecture Summary**
This Terraform project provisions:
- **1 VPC** spanning multiple Availability Zones
- **6 Subnets** (2 per tier)
  - Web Tier → Public Subnets
  - App Tier → Private Subnets
  - DB Tier → Private Subnets
- **5 Security Groups** securing each tier & load balancer
- **External Application Load Balancer** (Web Tier)
- **Internal Application Load Balancer** (App Tier)
- **Auto Scaling Groups** with launch templates for both Web & App tiers
- **Internet & NAT Gateway** for controlled internet access
- **Route Tables** for traffic routing
- **RDS MySQL Instance** in private subnets

---

## 🧱 **Infrastructure Layout**
### **VPC & Subnets**
- **VPC:** Main private networking boundary for the project
- **Subnets:**
  - **2 Public (Web Tier)**
  - **2 Private (App Tier)**
  - **2 Private (DB Tier)**
- All subnets distributed across **two AZs** for high availability

---

## 🌐 **Networking Components**
### **Internet Gateway (IGW)**
Allows outbound internet access for public tier resources.

### **NAT Gateway**
Enables private subnets to access the internet **securely without exposing them publicly**.

### **Route Tables**
| Route Table | Associated Subnets | Routes |
|-------------|--------------------|--------|
| Public RT | Public Web Subnets | Local + IGW |
| Private RT | App & DB Subnets | Local + NAT Gateway |

---

## 🔐 **Security Groups (5 Total)**
1. **External ALB SG** → Allows HTTP/HTTPS from the internet
2. **Web Tier EC2 SG** → Allows traffic only from the External ALB
3. **Internal ALB SG** → Receives traffic from Web Tier
4. **App Tier EC2 SG** → Receives traffic from Internal ALB
5. **DB MySQL SG** → Allows MySQL (3306) only from App Tier

---

## ⚖️ **Load Balancers & Target Groups**
### **External ALB – Web Tier**
- Public-facing
- Listens on **80/443**
- Routes traffic to **Web Tier Target Group**

### **Internal ALB – App Tier**
- Private-facing
- Usually listens on **80 or 8080**
- Routes traffic to **App Tier Target Group**

---

## 🖥️ **Compute Layer – EC2 + Auto Scaling**
### **Web Tier**
- **Launch Template** (AMI, instance type, security group, user data)
- **Auto Scaling Group** across public subnets
- Registered with External ALB target group

### **App Tier**
- **Launch Template** (AMI, instance type, security group, user data)
- **Auto Scaling Group** across private subnets
- Registered with Internal ALB target group

---

## 🗄️ **Database Layer – Amazon RDS MySQL**
- **DB Subnet Group** created using private DB subnets
- **MySQL RDS Instance** deployed in private tier
- Secured using the DB MySQL SG
- (Optional: Multi-AZ deployment for production resilience)

---

## 🔄 **Terraform Deployment Flow**
1. Create VPC
2. Create Subnets
3. Provision IGW & NAT Gateway
4. Configure Route Tables
5. Deploy Security Groups
6. Create External & Internal ALBs
7. Configure Target Groups + Listeners
8. Launch Templates & Auto Scaling Groups
9. Create RDS Subnet Group
10. Deploy MySQL RDS Instance

---

## 📤 **Recommended Terraform Outputs**
These can be added to outputs.tf:
- External ALB DNS
- Internal ALB DNS
- RDS Endpoint
- ASG names

---

##  **Visual Architecture Diagram **
```
![three_tier_design](https://github.com/user-attachments/assets/e7472151-9cf4-4e89-9437-0b8655ed231a)

```
---

## 📁 **Terraform Project Structure**
A simple and clean structure where **each service has its own .tf file**, plus user‑data for EC2 bootstrap scripts.

```
three-tier-aws-infra/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
│
├── vpc.tf
├── subnets.tf
├── route-tables.tf
├── internet-gateway.tf
├── nat-gateway.tf
│
├── security-groups.tf
│
├── external-alb.tf
├── internal-alb.tf
├── target-groups.tf
│
├── web-launch-template.tf
├── app-launch-template.tf
├── web-asg.tf
├── app-asg.tf
│
├── rds-subnet-group.tf
├── rds-instance.tf
│
└── user-data/
       ├── app-script.sh
       └── web-script.sh
```

---

## 🚀 **How to Deploy the Infrastructure**
Follow these steps to deploy your three‑tier architecture on AWS using Terraform.

### **1️⃣ Initialize Terraform**
```
terraform init
```
Downloads required providers and configures backend (if any).

### **2️⃣ Validate the Configuration**
```
terraform validate
```
Ensures all syntax and configurations are correct.

### **3️⃣ Preview the Infrastructure Changes**
```
terraform plan
```
Shows the resources Terraform will create.

### **4️⃣ Deploy the Infrastructure**
```
terraform apply
```
Type **yes** when prompted.

### **5️⃣ After Deployment – Useful Outputs**
You should see:
- External ALB DNS
- Internal ALB DNS


### **6️⃣ Destroy Environment (Optional)**
```
terraform destroy
```
Type **yes** when prompted.
Cleanly removes all resources.

---

## 📚 **Conclusion****
This Terraform setup creates a fully modular, scalable, and secure **3-tier AWS environment** suitable for production-grade workloads. It follows AWS best practices, ensuring:
- High availability
- Network isolation
- Secure communication between tiers
- Automatic scaling

If you'd like, I can also generate:
✅ Terraform folder structure
✅ A more visual architecture diagram
✅ A prettier GitHub badge section

Just tell me! 🚀

