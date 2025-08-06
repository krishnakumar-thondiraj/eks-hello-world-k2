resource "kubernetes_storage_class" "default_gp2" {
  metadata {
    name = "gp2"

    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true"
    }
  }

  storage_provisioner = "kubernetes.io/aws-ebs"  # or "ebs.csi.aws.com" if you're using CSI

  parameters = {
    type   = "gp2"
    fsType = "ext4"
  }

  reclaim_policy      = "Retain"
  volume_binding_mode = "WaitForFirstConsumer"
}

