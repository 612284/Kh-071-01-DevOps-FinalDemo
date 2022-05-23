resource "aws_iam_role" "init_build_role" {
  name = "init_build-role-${var.env}-${var.app_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
resource "aws_iam_instance_profile" "this" {
  name = "profile-${var.env}-${var.app_name}"
  role = aws_iam_role.init_build_role.name
}

resource "aws_iam_role_policy" "initbuild_policy" {
  role = aws_iam_role.init_build_role.name
  name = "init_build-policy-${var.env}-${var.app_name}"

  policy = <<POLICY
{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "ecr:PutLifecyclePolicy",
                  "ecr:PutImageTagMutability",
                  "ecr:StartImageScan",
                  "ecr:CreateRepository",
                  "ecr:PutImageScanningConfiguration",
                  "ecr:UploadLayerPart",
                  "ecr:BatchDeleteImage",
                  "ecr:DeleteLifecyclePolicy",
                  "ecr:DeleteRepository",
                  "ecr:PutImage",
                  "ecr:CompleteLayerUpload",
                  "ecr:StartLifecyclePolicyPreview",
                  "ecr:InitiateLayerUpload",
                  "ecr:DeleteRepositoryPolicy",
                  "ecr:BatchGetImage",
                  "ecr:GetDownloadUrlForLayer"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": "ecr:GetAuthorizationToken",
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": "ecr:BatchCheckLayerAvailability",
              "Resource": "*"
          }
      ]
}
POLICY
}
