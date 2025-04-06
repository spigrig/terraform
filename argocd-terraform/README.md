# ArgoCD Installation with Terraform on Minikube

This project provides a Terraform configuration to deploy **ArgoCD** on a **Minikube** Kubernetes cluster using the **Helm provider**.

## 📁 Project Structure

```
argocd-terraform/
├── main.tf           # Terraform configuration for installing ArgoCD via Helm
├── values.yaml       # Custom Helm values for configuring ArgoCD
├── outputs.tf        # Terraform output with ArgoCD URL
└── README.md         # Project overview and instructions
```

## 🚀 Prerequisites

Ensure you have the following installed:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Helm](https://helm.sh/docs/intro/install/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

Make sure your Minikube cluster is running:

```bash
sudo swapoff -a
docker context use desktop-linux
minikube start
```

Generate a kubeconfig file dedicated for Terraform:
```bash
kubectl config view --minify --flatten > minikube-kubeconfig.yaml
```

## 🛠️ Deployment Steps

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Apply the configuration:
   ```bash
   terraform apply
   ```
   Accept the plan with `yes`.

3. Access ArgoCD Web UI:
   ```bash
   minikube service argocd-server -n argocd --url
   ```
   Copy the output URL and open it in your browser.

4. Get ArgoCD Admin Password:
   ```bash
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d && echo
   ```

## ✅ Login to ArgoCD
- **Username:** `admin`
- **Password:** (from the previous command)

## 🧹 Clean Up
```bash
terraform destroy
minikube delete --all
```
