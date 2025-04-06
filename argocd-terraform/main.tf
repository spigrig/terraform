# This Terraform configuration sets up a Helm provider to manage Kubernetes resources using Helm charts.
# 
# - The `provider "helm"` block configures the Helm provider to use a specific kubeconfig file for connecting to a Kubernetes cluster.
#   - `config_path`: Specifies the path to the kubeconfig file, which is dynamically set to `minikube-kubeconfig.yaml` in the current module directory.
# 
# - The `resource "helm_release" "argocd"` block defines a Helm release for deploying Argo CD in the Kubernetes cluster.
#   - `name`: The name of the Helm release, set to "argocd".
#   - `namespace`: The Kubernetes namespace where the release will be deployed, set to "argocd".
#   - `chart`: Specifies the Helm chart to use, in this case, "argo-cd".
#   - `repository`: The URL of the Helm chart repository, pointing to the official Argo Helm repository.
#   - `version`: The specific version of the Helm chart to deploy, set to "7.8.23".
#   - `create_namespace`: A boolean flag to automatically create the namespace if it does not exist.
#   - `values`: A list of custom values files to override default chart values, referencing the `values.yaml` file in the current module directory.

provider "helm" {
  kubernetes {
    config_path = "${path.module}/minikube-kubeconfig.yaml"
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