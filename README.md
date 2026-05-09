# Damolak App — Production DevOps Deployment

A **production-ready web application** deployed on **Amazon Web Services (AWS)** using modern DevOps practices including **Terraform Infrastructure as Code**, **Docker containerization**, and a fully automated **Jenkins CI/CD pipeline**.

> ✅ **Project successfully executed, automated, and fully operational**

---

## Application Overview

The Damolak App is a responsive HTML5 web application served through **Nginx inside a Docker container**, automatically built and deployed to an AWS EC2 App Server via a Jenkins pipeline running on a separate Jenkins EC2 server.

The web files used for this project were sourced from a public HTML template and slightly modified to fit the project purpose.

---

## Architecture & Infrastructure Design

The complete infrastructure architecture and Terraform tree structures are provided in:

* `assets/damalok_architecture.png`
* `assets/damalok_structures.png`

These diagrams illustrate:

* VPC, Subnet, Security Groups
* Jenkins Server and App Server
* Elastic IP allocation
* IAM roles and policies
* Docker deployment flow
* CI/CD pipeline integration
* CloudWatch monitoring
* S3 remote Terraform backend
* ECR image registry flow

---

## GitHub Repositories

This project is organized into **two dedicated GitHub repositories** to clearly separate **Infrastructure as Code** from the **Application & CI/CD pipeline**, following real-world DevOps repository standards.

| Repository                | Purpose                                                                        | Link                                                                                                         |
| ------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| Damolak_Jenkins_Terraform | Terraform provisioning for VPC, EC2, SG, IAM, EIP, S3 backend, ECR, CloudWatch | [Damalok_Jenkins_Terraform](https://github.com/JohnehChuks/Damolak_Jenkins_Terraform?utm_source=chatgpt.com) |
| Damolak_App               | Web app source code, Dockerfile, Jenkinsfile, deployment pipeline              | [Damalok_App](https://github.com/JohnehChuks/Damolak_App?utm_source=chatgpt.com)                             |

---

## Tools & Technologies Used

| Tool           | Purpose                                                     |
| -------------- | ----------------------------------------------------------- |
| Terraform      | Infrastructure as Code (VPC, EC2, SG, IAM, EIP, S3 backend) |
| Docker         | Application containerization                                |
| Jenkins        | CI/CD automation server                                     |
| AWS EC2        | Jenkins Server & Application Server                         |
| AWS ECR        | Docker image registry                                       |
| AWS S3         | Remote Terraform state backend                              |
| AWS CloudWatch | Monitoring and logging                                      |
| Apache2        | Reverse proxy on App Server                                 |
| Git & GitHub   | Source code management                                      |
| Nginx          | Web server inside container                                 |

---

## Full Project Structure

```
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
│   ├── damolak.tfplan
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── README.md
│
├── key/
│   ├── damolak_app_keypair.pem
│   ├── damolak_app_keypair.pem.pub
│   └── damolak_jenkins_keypair.pem
│
├── scripts/
│   ├── app_userdata.sh
│   └── jenkins_userdata.sh
│
├── Damolak_Root/
│   └── damolak/
│       ├── index.html
│       ├── about-us.html
│       ├── our-services.html
│       ├── contact-us.html
│       ├── assets/
│       └── vendor/
│
├── Dockerfile
├── Jenkinsfile
└── README.md
```

---

## CI/CD Pipeline Workflow (Jenkins)

The Jenkins pipeline automates the entire deployment lifecycle.

| Stage  | Action                                                   |
| ------ | -------------------------------------------------------- |
| Clone  | Pull latest code from GitHub `developer` branch          |
| Build  | Build Docker image using Nginx                           |
| Test   | Run container and validate with curl                     |
| Push   | Push Docker image to AWS ECR                             |
| Deploy | SSH to App server, pull image from ECR and run container |

---

## Deployment URLs

| Resource          | URL                                                  |
| ----------------- | ---------------------------------------------------- |
| Live Application  | [http://54.77.250.195](http://54.77.250.195)         |
| Jenkins Dashboard | [http://52.50.38.231:8080](http://52.50.38.231:8080) |

---

## Docker Configuration

```dockerfile
FROM nginx:alpine
COPY damolak/ /usr/share/nginx/html/
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
```

Apache2 on the App Server proxies:

```
Port 80  →  Docker container port 3000
```

---

## Design Decisions & Rationale

| Decision                         | Reason                                  |
| -------------------------------- | --------------------------------------- |
| Separate Jenkins and App servers | Production-style separation of concerns |
| Terraform modular files          | Reusable, readable IaC structure        |
| S3 remote backend                | State consistency and team readiness    |
| Docker + Nginx                   | Lightweight and ideal for static apps   |
| Apache reverse proxy             | Clean exposure of container service     |
| ECR for images                   | Industry standard image registry        |
| CloudWatch integration           | Monitoring and logging capability       |
| Elastic IPs                      | Stable public access to servers         |

---

## Assumptions

* Jenkins has SSH access to App server
* Docker is installed on both servers via Terraform user_data
* IAM roles allow CloudWatch and ECR access
* Security groups allow SSH, HTTP, HTTPS, and Jenkins port 8080

---

## Limitations & Future Improvements

* Implement HTTPS using ACM / Let’s Encrypt
* Introduce Blue/Green or Rolling deployments
* Add SonarQube for code quality scanning
* Add Slack/email notifications from Jenkins
* Use Auto Scaling Group and Load Balancer
* Migrate from EC2 to ECS/EKS for container orchestration

---

## Outcome

This project successfully demonstrates:

* Infrastructure provisioning with Terraform
* Full CI/CD automation with Jenkins
* Containerized deployment with Docker
* AWS best practices using ECR, S3 backend, IAM, and CloudWatch
* Clean architecture and professional repository structure

> ✅ **Fully deployed, automated, and production-style environment aligned with real-world DevOps practices**
