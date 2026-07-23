# Technical Reflection: DevOps Message App

## Introduction

This project helped me understand how DevOps connects software development, infrastructure, automation, security, and performance into one complete delivery workflow. From the perspective of a DevOps Engineer, the project was not only about writing application code, but also about making the system buildable, deployable, secure, measurable, and maintainable.

## Version Control and Git Workflow

Git was used as the main source control tool. The project was pushed to GitHub so the application code, Docker configuration, CI/CD workflow, security scan configuration, and performance benchmark scripts could be managed in one repository.

I learned that Git is not only for storing source code. It is also important for tracking infrastructure-related files such as Dockerfiles, deployment scripts, GitHub Actions workflows, and security scan configurations. This makes the project easier to review, reproduce, and improve.

## Containerization with Docker

Docker was used to package the frontend and backend into separate containers. The backend runs as a Node.js Express API, while the frontend is served by Nginx. Docker Compose was used to run both services together.

This helped me understand how container networking, port mapping, image building, and service dependencies work in practice. It also showed why containers are useful for keeping local and cloud environments consistent.

## CI/CD Pipeline

GitHub Actions was used to automate backend testing and Docker image building. The pipeline checks the project every time code is pushed to the main branch.

This showed me that CI/CD reduces manual work and improves reliability. Instead of relying only on local testing, the pipeline provides repeatable automation and makes it easier to detect problems earlier.

The project also includes a Jenkinsfile and deployment script to demonstrate how a Jenkins pipeline can deploy the latest code to a cloud server.

## Cloud Deployment

The application was deployed to AWS EC2 using an Ubuntu server. The deployment included installing Docker, cloning the GitHub repository, configuring Docker Compose, and exposing the required ports through AWS Security Group rules.

Important cloud concepts practiced in this project include:

- Creating an EC2 instance
- Configuring Security Groups
- Opening ports for SSH, frontend, and backend
- Installing Docker on a cloud server
- Pulling source code from GitHub
- Running containers with Docker Compose

This helped me understand the relationship between source code, cloud infrastructure, networking, and deployment.

## DevSecOps and Security

Security scanning was added using npm audit and Trivy. Before remediation, the backend dependencies had vulnerabilities. After updating dependencies and hardening the Dockerfiles, the npm audit result improved to zero vulnerabilities.

Security improvements included:

- Updating vulnerable dependencies
- Running backend container as a non-root user
- Using an unprivileged Nginx image
- Adding `no-new-privileges` to Docker Compose
- Adding Trivy scan workflow in GitHub Actions

This showed me that security should be part of the pipeline, not something done only after deployment.

## Performance Optimization

Performance optimization focused on Docker image size and load testing. Dockerfiles were improved using multi-stage builds and `.dockerignore` files. The backend image size was reduced from 285 MB to 235 MB, and the frontend image size was reduced from 92.7 MB to 81.4 MB.

Load testing was performed using Apache Benchmark. Requests per second improved from 1046.89 req/sec to 1185.84 req/sec, while average response time decreased from 47.761 ms to 42.164 ms.

This taught me that optimization should be measured with real data instead of assumptions.

## Challenges

The main challenges were:

- Handling AWS account and EC2 access
- Solving SSH key permission issues
- Updating EC2 after GitHub changes
- Fixing frontend-to-backend URL issues after cloud deployment
- Understanding the difference between local changes and GitHub as the source of truth
- Collecting before and after benchmark results correctly

These challenges were useful because they reflect real DevOps work where configuration, infrastructure, and application code must stay aligned.

## Lessons Learned

The most important lesson from this project is that DevOps is not just one tool. It is a workflow that combines coding, automation, containerization, cloud infrastructure, security, performance, and documentation.

I also learned that every change should be measurable. Security improvements were verified by scan results, and performance improvements were verified by benchmark results.

## Conclusion

This project provided practical experience across the DevOps lifecycle. I learned how to build, containerize, test, deploy, secure, benchmark, and document an application.

From a DevOps Engineer perspective, a production-ready system requires more than working application code. It also needs automation, security, repeatable deployment, performance validation, and clear documentation.
