resource "aws_iam_role" "aws-load-balancer-controller" {
  name = "aws-load-balancer-controller-${local.name_prefix}"

  assume_role_policy = templatefile(
    "${path.module}/assumed_policies/oidc_assumed.json",
    {
      OIDC_ARN  = local.eks_cluster_oidc_arn,
      OIDC_URL  = replace(local.eks_cluster_oidc_url, "https://", ""),
      NAMESPACE = "kube-system",
      SA_NAME   = "aws-load-balancer-controller"
    }
  )

  tags = {
    "ServiceAccountName"      = "aws-load-balancer-controller"
    "ServiceAccountNameSpace" = "kube-system"
  }
}

resource "aws_iam_role_policy" "aws-load-balancer-controller" {
  name   = "load-balancer-controller-${local.name_prefix}-policy"
  role   = aws_iam_role.aws-load-balancer-controller.id
  policy = data.aws_iam_policy_document.aws-load-balancer-controller.json
}