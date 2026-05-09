# Damolak App — DevOps Challenge

A production-ready application deployment using modern DevOps practices.

---

## Architecture Overview
Browser
│
▼
Apache2 (port 80) — App Server: 99.80.245.28
│
▼
Docker Container — Nginx (port 3000)
│
▼
Damolak HTML Application

## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure provisioning |
| AWS EC2 | Cloud servers |
| Jenkins | CI/CD pipeline |
| Docker | Containerization |
| Nginx | Web server inside container |
| Apache2 | Reverse proxy on App server |
| Git | Version control |

---

## Deployment Steps

### 1. Infrastructure
```bash
cd damolak-terraform
export TF_VAR_aws_access_key=$Damolak_key
export TF_VAR_aws_secret_key=$Damolak_secret_key
terraform init
terraform apply
```

### 2. Access Jenkins
http://52.50.38.231:8080

### 3. Run Pipeline
- Open Jenkins
- Click damolak-pipeline
- Click Build Now

### 4. Access App
http://99.80.245.28

---

## CI/CD Pipeline Stages

| Stage | What Happens |
|---|---|
| Clone | Pulls latest code from GitHub |
| Build | Builds Docker image from Dockerfile |
| Test | Runs container and tests with curl |
| Deploy | Stops old container and runs new one |

---

## Design Decisions

- Used Nginx inside Docker for serving static files — lightweight and fast
- Apache2 on App server acts as reverse proxy to Docker container
- Elastic IPs used on both servers to maintain static IP addresses
- Separate security groups for Jenkins and App server
- Single shared VPC for both servers
- Remote Terraform state stored in S3 with DynamoDB locking

---

## Assumptions

- AWS credentials exported as environment variables
- Both servers in eu-west-1 region
- Ubuntu 24.04 LTS AMI used for both servers
- Jenkins and App server on same VPC and subnet

---

## Limitations and Improvements

- Add HTTPS using AWS Certificate Manager and Load Balancer
- Move App server to private subnet for better security
- Add auto-scaling for production workloads
- Add Slack notifications to Jenkins pipeline
- Add automated rollback on deployment failure