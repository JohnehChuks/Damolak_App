````markdown
# Damolak App — Production DevOps Deployment

A production-ready web application deployed on **Amazon Web Services (AWS)** using modern DevOps practices including **Terraform Infrastructure as Code**, **Docker containerization**, and a fully automated **Jenkins CI/CD pipeline**.

✅ Project successfully executed, automated, and fully operational

**Production-ready web App source:** Mexant Financial HTML5 template.

---

# Application Overview

The Damolak App is a responsive HTML5 web application served through **Nginx inside a Docker container**, automatically built and deployed to an AWS EC2 App Server through a Jenkins pipeline running on a separate Jenkins EC2 server.

The web files used for this project were sourced from a public HTML template and professionally customized for deployment purposes.

---

# Architecture & Infrastructure Design

The complete infrastructure architecture and Terraform tree structures are provided in the project documentation files:

- `damolak_terraform/App_Structural_Design.pdf`
- `damolak_terraform/App_Structural_Design.mht`
- `Damolak_App/App_Structural_Design.pdf`
- `Damolak_App/App_Structural_Design.mht`

These diagrams illustrate:

- VPC, Subnet, Route Tables, Internet Gateway
- Jenkins Server and App Server
- Elastic IP allocation
- IAM roles and policies
- Docker deployment flow
- Jenkins CI/CD pipeline flow
- CloudWatch monitoring & alarms
- S3 Terraform remote backend
- ECR image registry workflow

---

# GitHub Repositories

This project is separated into two repositories following real-world DevOps standards.

| Repository | Purpose |
|-----------|---------|
| Damolak_Jenkins_Terraform | Infrastructure provisioning (VPC, EC2, SG, IAM, EIP, S3 backend, ECR, CloudWatch) |
| Damolak_App | Web app source code, Dockerfile, Jenkinsfile, CI/CD deployment |

---

# Tools & Technologies Used

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code |
| Docker | Application containerization |
| Jenkins | CI/CD automation |
| AWS EC2 | Jenkins Server & App Server |
| AWS ECR | Docker image registry |
| AWS S3 | Terraform remote state backend |
| AWS DynamoDB | Terraform state locking |
| AWS CloudWatch | Monitoring and logging |
| Apache2 | Reverse proxy on App Server |
| Git & GitHub | Source control |
| Nginx | Web server inside container |

---

# Full Project Structure

```bash
Web_App_Integration_&_deployment/
│
├── Damolak_Terraform/
│   ├── Damolak_app_server.tf
│   ├── Damolak_backend.tf
│   ├── Damolak_cloudwatch.tf
│   ├── Damolak_ecr.tf
│   ├── Damolak_iam.tf
│   ├── Damolak_jenkens_server.tf
│   ├── Damolak_output.tf
│   ├── Damolak_sg.tf
│   ├── Damolak_variables.tf
│   ├── Damolak_vpc.tf
│   ├── main.tf
│   ├── terraform.tfvars
│   ├── bootstrap.sh
│   ├── README.md
│   ├── App_Structural_Design.pdf
│   └── App_Structural_Design.mht
│
├── key/
│   ├── damolak_app_keypair.pem
│   └── damolak_jenkins_keypair.pem
│
├── scripts/
│   ├── app_userdata.sh
│   └── jenkins_userdata.sh
│
├── damolak/
│   ├── index.html
│   ├── about-us.html
│   ├── contact-us.html
│   ├── our-services.html
│   ├── assets/
│   └── vendor/
│
├── Dockerfile
├── Jenkinsfile
├── README.md
└── .gitignore
````

---

# CI/CD Pipeline Workflow (Jenkins)

The Jenkins pipeline automates the full deployment lifecycle.

| Stage  | Action                                        |
| ------ | --------------------------------------------- |
| Clone  | Pull latest code from GitHub developer branch |
| Build  | Build Docker image                            |
| Test   | Run container and validate with curl          |
| Push   | Push image to AWS ECR                         |
| Deploy | SSH into App Server and run latest container  |

---

# Deployment URLs

| Resource          | URL                                                  |
| ----------------- | ---------------------------------------------------- |
| Live Application  | [http://54.77.250.195](http://54.77.250.195)         |
| Jenkins Dashboard | [http://52.50.38.231:8080](http://52.50.38.231:8080) |

---

# Docker Configuration

```dockerfile
FROM nginx:alpine
COPY damolak/ /usr/share/nginx/html/
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
```

Apache2 on the App Server reverse proxies:

```text
Port 80  →  Docker Container Port 3000
```

---

# Design Decisions & Rationale

| Decision                         | Reason                            |
| -------------------------------- | --------------------------------- |
| Separate Jenkins and App servers | Production-style separation       |
| Terraform modular files          | Readable and scalable IaC         |
| S3 backend + DynamoDB            | Safe remote state                 |
| Docker + Nginx                   | Lightweight static app deployment |
| Apache reverse proxy             | Clean traffic routing             |
| ECR for images                   | Industry-standard image registry  |
| CloudWatch integration           | Monitoring and alerts             |
| Elastic IPs                      | Stable public access              |

---

# Assumptions

* Jenkins has SSH access to App Server
* Docker installed automatically via user_data
* IAM role permits ECR and CloudWatch access
* Security groups allow SSH, HTTP, HTTPS, Jenkins 8080

---

# Limitations & Future Improvements

* Add HTTPS using ACM / Let’s Encrypt
* Blue/Green deployments
* SonarQube code quality scanning
* Slack / Email Jenkins alerts
* Auto Scaling Group + Load Balancer
* Move workloads to ECS / EKS
* Add WAF and private subnet design

---

# Outcome

This project successfully demonstrates:

* Infrastructure provisioning with Terraform
* Full CI/CD automation with Jenkins
* Containerized deployment with Docker
* AWS best practices using ECR, S3 backend, IAM, and CloudWatch
* Clean architecture and professional repository structure
* Real-world DevOps workflow implementation

✅ Fully deployed, automated, and production-style environment aligned with real-world DevOps engineering standards.

```
```
