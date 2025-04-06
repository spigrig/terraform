# This Terraform configuration deploys ArgoCD using the Helm provider.
# 
# - The `helm` provider is configured to interact with a Kubernetes cluster using the kubeconfig file located at `~/.kube/config` and the context set to `minikube`.
# 
# - A Helm release resource (`helm_release`) is defined to install the ArgoCD Helm chart:
#   - The release is named "argocd" and is deployed in the "argocd" namespace.
#   - The chart used is "argo-cd" from the official Argo Helm repository: `https://argoproj.github.io/argo-helm`.
#   - The specific version of the chart being installed is `7.8.23`.
#   - The `create_namespace` attribute ensures that the "argocd" namespace is created if it does not already exist.
#   - Custom values for the Helm chart are provided via a `values.yaml` file located in the same module directory as the Terraform configuration.

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
    context     = "minikube"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "7.8.23"

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}