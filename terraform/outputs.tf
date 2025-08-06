output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}"
}
