# Continuous Integration/Continuous Delivery with GCP


## Overview

This is a simple demo on the usage of Google's [Cloud Build](https://cloud.google.com/cloud-build), [Kubernetes Engine](https://cloud.google.com/kubernetes-engine) and [Container Registry](https://cloud.google.com/container-registry), with [Docker](https://www.docker.com/), [Git](https://git-scm.com/) and [GitHub](https://github.com/) to build a CI/CD pipeline. Here’s a diagram that summarizes the workflow:

![cicd-diagram](https://github.com/htrungngx/GCP-Devops/assets/83159640/4497606d-7ff6-47e1-9b6f-2ea42122552f)


1. Code is pushed to GitHub.
2. GitHub triggers a post-commit hook to Cloud Build.
3. Cloud Build creates the container image and pushes it to Container Registry.
4. Cloud Build notifies Google Kubernetes Engine to roll out a new deployment.
5. Google Kubernetes Engine pulls the image from Container Registry and runs it.


<img width="812" alt="Screenshot 2023-10-24 at 23 35 54" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/378fea9f-7863-4635-af77-969f8a24dbe3">
<img width="1191" alt="Screenshot 2023-10-24 at 23 35 42" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/1bdfa8da-4956-4890-a639-ab567196c2bc">
<img width="988" alt="Screenshot 2023-10-24 at 23 34 49" src="https://github.com/htrungngx/GCP-Devops/assets/83159640/ef2006bb-f0d7-49a1-90d1-e38bb8a0efc9">
