# This output block defines the `argocd_url` output variable, which provides the URL
# for accessing the ArgoCD instance. The value is currently set to "https://localhost:8080".
# This output can be used to reference the ArgoCD URL in other Terraform configurations
# or as part of deployment scripts.

output "argocd_url" {
  description = "ArgoCD Web UI URL"
  value = "https://localhost:8080"
}