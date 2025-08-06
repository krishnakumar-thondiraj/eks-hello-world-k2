# Fetch EKS cluster details
data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.eks.name
}

# Get TLS thumbprint of the OIDC provider
data "tls_certificate" "oidc_thumbprint" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

# Create IAM OIDC provider for EKS
resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

