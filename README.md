# Damolak App — DevOps Challenge

A production-ready web application deployed using modern DevOps practices.

---

## Application Overview

A responsive financial HTML5 web application served via Nginx inside a Docker container, deployed automatically through a Jenkins CI/CD pipeline.

---

## Repository Structure

Damolak_Root/
├── damolak/          ← HTML web application
│   ├── index.html
│   ├── about-us.html
│   ├── our-services.html
│   ├── contact-us.html
│   ├── assets/
│   └── vendor/
├── Dockerfile        ← Builds Nginx container serving the app
├── Jenkinsfile       ← CI/CD pipeline definition
└── README.md         ← This file

---

## Tech Stack

| Tool | Purpose |
|---|---|
| HTML5 / CSS3 / JS | Frontend application |
| Docker + Nginx | Containerization and web serving |
| Jenkins | CI/CD pipeline |
| Apache2 | Reverse proxy on App server |
| GitHub | Source code management |

---

## CI/CD Pipeline

The `Jenkinsfile` defines a 4-stage pipeline:

| Stage | What Happens |
|---|---|
| Clone | Pulls latest code from GitHub developer branch |
| Build | Builds Docker image using Nginx alpine |
| Test | Runs container and verifies with curl |
| Deploy | Copies image to App server and runs container |

---

## Application URLs

| Resource | URL |
|---|---|
| Live App | http://54.77.250.195 |
| Jenkins | http://52.50.38.231:8080 |

---

## Deployment Steps

### Automatic (via Jenkins)
1. Push code to `developer` branch
2. Jenkins automatically picks up changes
3. Pipeline builds, tests and deploys

### Manual Pipeline Trigger
1. Open Jenkins at `http://52.50.38.231:8080`
2. Click `damolak-pipeline`
3. Click `Build Now`

---

## Docker Details

The app runs inside an Nginx Alpine container:

```dockerfile
FROM nginx:alpine
COPY damolak/ /usr/share/nginx/html/
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
```

Apache2 on the App server proxies port 80 → container port 3000.

---

## Design Decisions

| Decision | Rationale |
|---|---|
| Nginx inside Docker | Lightweight and fast for static HTML |
| Apache2 as reverse proxy | Decouples web layer from container |
| Developer branch workflow | Protects main branch from untested code |
| Direct server deployment | Simple and effective for challenge scope |

---

## Assumptions

- Jenkins server has SSH access to App server via private IP
- App server has Docker installed and running
- Apache2 configured as reverse proxy to port 3000

---

## Limitations and Future Improvements

- Push Docker images to **AWS ECR** instead of direct transfer
- Add **HTTPS** using Let's Encrypt or AWS Certificate Manager
- Implement **Blue/Green deployment** for zero downtime
- Add **automated rollback** on deployment failure
- Add **Slack notifications** for pipeline status
- Add **SonarQube** for code quality scanning
- Use **Docker Compose** for multi-container setups

