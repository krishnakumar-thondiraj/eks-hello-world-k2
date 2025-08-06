# Hello World on EKS with Terraform and Helm

This project demonstrates how to deploy a simple "Hello World" application on Amazon EKS (Elastic Kubernetes Service), including a Redis dependency, using Terraform and Helm.

---

## 📦 What's Included

- **Amazon EKS Cluster** provisioning with Terraform
- **EBS CSI Driver** setup for dynamic storage provisioning
- **Helm-based deployment** of a Hello World app with Redis backend
- **Automatic volume creation** for Redis via Persistent Volume Claims

---

## ✅ Prerequisites

Before you begin, make sure you have:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Helm](https://helm.sh/docs/intro/install/)
- AWS IAM credentials with EKS and EC2 access
- A configured AWS profile: `aws configure`

---

## 🚀 Deployment Steps

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/eks-hello-world.git
cd eks-hello-world
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Apply the Terraform Plan

This will:
- Create a VPC and subnets
- Create an EKS cluster
- Set up the EBS CSI driver
- Configure OIDC
- Install necessary IAM roles

```bash
terraform apply
```

🛑 Type `yes` when prompted.

### 4. Configure kubectl

Once Terraform finishes, set up your kubeconfig to interact with the new cluster:

```bash
aws eks update-kubeconfig --region us-east-1 --name eks-hello-world
```

Replace the region and cluster name if different.

### 5. Install the Application Using Helm

```bash
helm install hello ./hello-world-chart
```

This installs:
- A simple Hello World web service
- Redis (as a dependency)
- A PersistentVolumeClaim for Redis data

---

## 📡 Access the Application

You can port-forward the Hello World app like this:

```bash
kubectl port-forward svc/hello-hello-world 8080:80
```

Then open http://localhost:8080 in your browser.

---

## 🧹 Cleanup

To delete everything:

```bash
helm uninstall hello
terraform destroy
```

---

## 🛠 Troubleshooting

If Redis pod is stuck in Pending:

- Make sure the EBS CSI driver is installed and OIDC is correctly configured
- Check PVC status:

```bash
kubectl describe pvc
```

- Check IAM Role trust policy for EBS CSI driver includes `sts:AssumeRoleWithWebIdentity`

---

## 📁 Project Structure

```
.
├── main.tf                  # EKS cluster & VPC
├── ebs-csi.tf               # EBS CSI driver setup
├── oidc.tf                  # OIDC provider for IAM roles
├── storageclass.tf          # gp2 StorageClass setup
├── hello-world-chart/       # Helm chart for Hello World app
└── README.md                # You're here!
```