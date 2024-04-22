# Continuous Integration/Continuous Delivery with GCP

## Overview

This is a simple demo on the usage of Google's [Cloud Build](https://cloud.google.com/cloud-build), [Kubernetes Engine](https://cloud.google.com/kubernetes-engine) and [Container Registry](https://cloud.google.com/container-registry), with [Docker](https://www.docker.com/), [Git](https://git-scm.com/) and [GitHub](https://github.com/) to build a CI/CD pipeline. Here’s a diagram that summarizes the workflow:

## Diagram
![cicd-diagram](https://github.com/htrungngx/GCP-Devops/assets/83159640/4497606d-7ff6-47e1-9b6f-2ea42122552f)


1. Code is pushed to GitHub.
2. GitHub triggers a post-commit hook to Cloud Build.
3. Cloud Build creates the container image and pushes it to Container Registry.
4. Cloud Build notifies Google Kubernetes Engine to roll out a new deployment.
5. Google Kubernetes Engine pulls the image from Container Registry and runs it.


### Dockerfile

```
FROM node:alpine AS base
WORKDIR /app
COPY package*.json ./
RUN npm install 
COPY . .

FROM node:alpine as production 
WORKDIR /app
COPY --from=base /app .
EXPOSE 3000
CMD ["npm", "start"]

```

### CI/CD steps (cloudbuild.yaml)
```
steps:
# Step 1
- name: 'gcr.io/cloud-builders/docker'
  entrypoint: 'bash'
  args: [
   '-c',
   'docker pull gcr.io/htrung-cicd-project/todo-image:latest || exit 0'
  ]
# Step 2
- name: gcr.io/cloud-builders/docker
  args: [
   'build',
   '-t',
   'gcr.io/htrung-cicd-project/todo-image:latest',
   '.'
  ]
# Step 3
- name: 'gcr.io/cloud-builders/kubectl'
  args: ['apply', '-f', 'k8s/']
  env:
  - 'CLOUDSDK_COMPUTE_ZONE=europe-west1-d'
  - 'CLOUDSDK_CONTAINER_CLUSTER=gke-my-app-node'
# Step 4
- name: 'gcr.io/cloud-builders/kubectl'
  args: [
   'set',
   'image',
   'deployment',
   'todo-image',
   'todo-image=gcr.io/htrung-ci-cd/todo-image:latest'
  ]
  env:
  - 'CLOUDSDK_COMPUTE_ZONE=europe-west1-d'
  - 'CLOUDSDK_CONTAINER_CLUSTER=gke-my-app-node'
  # Push the image to Google Container Registry with the latest tag
images: [
   'gcr.io/htrung-cicd-project/todo-image:latest'
  ]

```

## Result 
<img width="812" alt="Screenshot 2023-10-24 at 23 35 54" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/378fea9f-7863-4635-af77-969f8a24dbe3">
<img width="1191" alt="Screenshot 2023-10-24 at 23 35 42" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/1bdfa8da-4956-4890-a639-ab567196c2bc">
<img width="988" alt="Screenshot 2023-10-24 at 23 34 49" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/ef2006bb-f0d7-49a1-90d1-e38bb8a0efc9">

## Clone
Clone the project to any directory where you do development work
```
git clone https://github.com/htrungngx/GCP-Devops.git
```
