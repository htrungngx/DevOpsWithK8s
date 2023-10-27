# Continuous Integration/Continuous Delivery with GCP


## Overview

This is a simple demo on the usage of Google's [Cloud Build](https://cloud.google.com/cloud-build), [Kubernetes Engine](https://cloud.google.com/kubernetes-engine) and [Container Registry](https://cloud.google.com/container-registry), with [Docker](https://www.docker.com/), [Git](https://git-scm.com/) and [GitHub](https://github.com/) to build a CI/CD pipeline. Here’s a diagram that summarizes the workflow:

<p align="center">
  <img src="todo-list/images/cicd-diagram.png">
</p>

1. Code is pushed to GitHub.
2. GitHub triggers a post-commit hook to Cloud Build.
3. Cloud Build creates the container image and pushes it to Container Registry.
4. Cloud Build notifies Google Kubernetes Engine to roll out a new deployment.
5. Google Kubernetes Engine pulls the image from Container Registry and runs it.


