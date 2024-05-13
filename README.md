# application

## Introduction</br>
This project aims to containerize and deploy a web application consisting of frontend and backend components using Kubernetes. The web application's frontend and backend will be containerized using Docker, and Kubernetes will be utilized for orchestrating the deployment, managing scaling, and ensuring reliability.

## Project Structure
- wordpress/: Contains Dockerfile and related files for the WordPress frontend.
- mysql/: Contains Dockerfile and related files for the MySQL backend.
- terraform/: Houses Terraform configuration files for deploying WordPress and MySQL pods to Minikube.
- README.md: Documentation for the project.

## Prerequisites
Ensure the following are installed:
- Docker for building container images.
- Minikube for local Kubernetes cluster setup.
- Terraform for infrastructure provisioning.
- Access to Docker Hub for image publication.

## Usage
### 1. Build Docker Images:
Navigate to the wordpress/ directory and build the WordPress Docker image:</br>
`docker build -t yourdockerhubusername/frontend:latest .`

Navigate to the mysql/ directory and build the MySQL Docker image:</br>
`docker build -t yourdockerhubusername/backend:latest .`

### 2. Push the built images to Docker Hub:</br>
`docker push yourdockerhubusername/frontend:latest`</br>
`docker push yourdockerhubusername/backend:latest`</br>

### 3. Deploy with Terraform:
Navigate to the terraform/ directory and initialize Terraform:</br>
`terraform init`

### 4. Apply the Terraform configuration to deploy WordPress and MySQL pods:
`terraform apply`

###5. Access WordPress Site:
After deployment, access the WordPress site using the Minikube IP and port:
`minikube service wordpress-service --url`

