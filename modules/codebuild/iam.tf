resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role-${var.env}-${var.app_name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs_full_access" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_role_policy" "cobebuild_policy" {
  role = aws_iam_role.codebuild_role.name
  name = "codebuild-policy-${var.env}-${var.app_name}"

  policy = <<POLICY
{
      "Statement": [
          {
              "Action": [
                  "acm:Describe*",
                  "acm:Get*",
                  "acm:List*",
                  "acm:Request*",
                  "acm:Resend*",
                  "autoscaling:*",
                  "cloudtrail:DescribeTrails",
                  "cloudtrail:GetTrailStatus",
                  "cloudtrail:ListPublicKeys",
                  "cloudtrail:ListTags",
                  "cloudtrail:LookupEvents",
                  "cloudtrail:StartLogging",
                  "cloudtrail:StopLogging",
                  "cloudwatch:*",
                  "codecommit:BatchGetRepositories",
                  "codecommit:CreateBranch",
                  "codecommit:CreateRepository",
                  "codecommit:Get*",
                  "codecommit:GitPull",
                  "codecommit:GitPush",
                  "codecommit:List*",
                  "codecommit:Put*",
                  "codecommit:Test*",
                  "codecommit:Update*",
                  "codedeploy:*",
                  "codepipeline:*",
                  "config:*",
                  "ds:*",
                  "ec2:Allocate*",
                  "ec2:AssignPrivateIpAddresses*",
                  "ec2:Associate*",
                  "ec2:Allocate*",
                  "ec2:AttachInternetGateway",
                  "ec2:AttachNetworkInterface",
                  "ec2:AttachVpnGateway",
                  "ec2:Bundle*",
                  "ec2:Cancel*",
                  "ec2:Copy*",
                  "ec2:CreateCustomerGateway",
                  "ec2:CreateDhcpOptions",
                  "ec2:CreateFlowLogs",
                  "ec2:CreateImage",
                  "ec2:CreateInstanceExportTask",
                  "ec2:CreateInternetGateway",
                  "ec2:CreateKeyPair",
                  "ec2:CreateLaunchTemplate",
                  "ec2:CreateLaunchTemplateVersion",
                  "ec2:CreateNatGateway",
                  "ec2:CreateNetworkInterface",
                  "ec2:CreatePlacementGroup",
                  "ec2:CreateReservedInstancesListing",
                  "ec2:CreateRoute",
                  "ec2:CreateRouteTable",
                  "ec2:CreateSecurityGroup",
                  "ec2:CreateSnapshot",
                  "ec2:CreateSpotDatafeedSubscription",
                  "ec2:CreateSubnet",
                  "ec2:CreateTags",
                  "ec2:CreateVolume",
                  "ec2:CreateVpc",
                  "ec2:CreateVpcEndpoint",
                  "ec2:CreateVpnConnection",
                  "ec2:CreateVpnConnectionRoute",
                  "ec2:CreateVpnGateway",
                  "ec2:DeleteFlowLogs",
                  "ec2:DeleteKeyPair",
                  "ec2:DeleteLaunchTemplate",
                  "ec2:DeleteLaunchTemplateVersions",
                  "ec2:DeleteNatGateway",
                  "ec2:DeleteNetworkInterface",
                  "ec2:DeletePlacementGroup",
                  "ec2:DeleteSnapshot",
                  "ec2:DeleteSpotDatafeedSubscription",
                  "ec2:DeleteSubnet",
                  "ec2:DeleteTags",
                  "ec2:DeleteVpc",
                  "ec2:DeleteVpcEndpoints",
                  "ec2:DeleteVpnConnection",
                  "ec2:DeleteVpnConnectionRoute",
                  "ec2:DeleteVpnGateway",
                  "ec2:DeregisterImage",
                  "ec2:Describe*",
                  "ec2:DetachInternetGateway",
                  "ec2:DetachNetworkInterface",
                  "ec2:DetachVpnGateway",
                  "ec2:DisableVgwRoutePropagation",
                  "ec2:DisableVpcClassicLinkDnsSupport",
                  "ec2:DisassociateAddress",
                  "ec2:DisassociateRouteTable",
                  "ec2:EnableVgwRoutePropagation",
                  "ec2:EnableVolumeIO",
                  "ec2:EnableVpcClassicLinkDnsSupport",
                  "ec2:GetConsoleOutput",
                  "ec2:GetHostReservationPurchasePreview",
                  "ec2:GetLaunchTemplateData",
                  "ec2:GetPasswordData",
                  "ec2:Import*",
                  "ec2:Modify*",
                  "ec2:MonitorInstances",
                  "ec2:MoveAddressToVpc",
                  "ec2:Purchase*",
                  "ec2:RegisterImage",
                  "ec2:Release*",
                  "ec2:Replace*",
                  "ec2:ReportInstanceStatus",
                  "ec2:Request*",
                  "ec2:Reset*",
                  "ec2:RestoreAddressToClassic",
                  "ec2:RunScheduledInstances",
                  "ec2:UnassignPrivateIpAddresses",
                  "ec2:UnmonitorInstances",
                  "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
                  "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                  "elasticloadbalancing:*",
                  "events:*",
                  "iam:GetAccount*",
                  "iam:GetContextKeys*",
                  "iam:GetCredentialReport",
                  "iam:ListAccountAliases",
                  "iam:ListGroups",
                  "iam:ListOpenIDConnectProviders",
                  "iam:ListPolicies",
                  "iam:ListPoliciesGrantingServiceAccess",
                  "iam:ListRoles",
                  "iam:ListSAMLProviders",
                  "iam:ListServerCertificates",
                  "iam:Simulate*",
                  "iam:UpdateServerCertificate",
                  "iam:UpdateSigningCertificate",
                  "kinesis:ListStreams",
                  "kinesis:PutRecord",
                  "kms:CreateAlias",
                  "kms:CreateKey",
                  "kms:DeleteAlias",
                  "kms:Describe*",
                  "kms:GenerateRandom",
                  "kms:Get*",
                  "kms:List*",
                  "kms:Encrypt",
                  "kms:ReEncrypt*",
                  "lambda:Create*",
                  "lambda:Delete*",
                  "lambda:Get*",
                  "lambda:InvokeFunction",
                  "lambda:List*",
                  "lambda:PublishVersion",
                  "lambda:Update*",
                  "logs:*",
                  "rds:Describe*",
                  "rds:ListTagsForResource",
                  "route53:*",
                  "route53domains:*",
                  "ses:*",
                  "sns:*",
                  "sqs:*",
                  "trustedadvisor:*"
              ],
              "Effect": "Allow",
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "imagebuilder:GetComponent",
                  "imagebuilder:GetContainerRecipe",
                  "dynamodb:*",
                  "ecr:GetAuthorizationToken",
                  "ecr:BatchGetImage",
                  "ecr:InitiateLayerUpload",
                  "ecr:UploadLayerPart",
                  "ecr:CompleteLayerUpload",
                  "ecr:BatchCheckLayerAvailability",
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:PutImage"
              ],
              "Resource": "*"
          },
          {
              "Effect": "Allow",
              "Action": [
                  "ecs:DescribeClusters",
                  "ecs:DescribeTaskDefinition",
                  "iam:CreateRole",
                  "ecs:CreateService",
                  "iam:CreateInstanceProfile"
              ],
              "Resource": "*"
          },
          {
              "Action": [
                  "ec2:AcceptVpcPeeringConnection",
                  "ec2:AttachClassicLinkVpc",
                  "ec2:AttachVolume",
                  "ec2:AuthorizeSecurityGroupEgress",
                  "ec2:AuthorizeSecurityGroupIngress",
                  "ec2:CreateVpcPeeringConnection",
                  "ec2:DeleteCustomerGateway",
                  "ec2:DeleteDhcpOptions",
                  "ec2:DeleteInternetGateway",
                  "ec2:DeleteNetworkAcl*",
                  "ec2:DeleteRoute",
                  "ec2:DeleteRouteTable",
                  "ec2:DeleteSecurityGroup",
                  "ec2:DeleteVolume",
                  "ec2:DeleteVpcPeeringConnection",
                  "ec2:DetachClassicLinkVpc",
                  "ec2:DetachVolume",
                  "ec2:DisableVpcClassicLink",
                  "ec2:EnableVpcClassicLink",
                  "ec2:GetConsoleScreenshot",
                  "ec2:RebootInstances",
                  "ec2:RejectVpcPeeringConnection",
                  "ec2:RevokeSecurityGroupEgress",
                  "ec2:RevokeSecurityGroupIngress",
                  "ec2:RunInstances",
                  "ec2:StartInstances",
                  "ec2:StopInstances",
                  "ec2:TerminateInstances"
              ],
              "Effect": "Allow",
              "Resource": [
                  "*"
              ]
          },
          {
              "Action": "s3:*",
              "Effect": "Allow",
              "Resource": [
                  "*"
              ]
          },
          {
              "Action": [
                  "iam:GetAccessKeyLastUsed",
                  "iam:GetGroup*",
                  "iam:GetInstanceProfile",
                  "iam:GetLoginProfile",
                  "iam:GetOpenIDConnectProvider",
                  "iam:GetPolicy*",
                  "iam:GetRole*",
                  "iam:GetSAMLProvider",
                  "iam:GetSSHPublicKey",
                  "iam:GetServerCertificate",
                  "iam:GetServiceLastAccessed*",
                  "iam:GetUser*",
                  "iam:ListAccessKeys",
                  "iam:ListAttached*",
                  "iam:ListEntitiesForPolicy",
                  "iam:ListGroupPolicies",
                  "iam:ListGroupsForUser",
                  "iam:ListInstanceProfiles*",
                  "iam:ListMFADevices",
                  "iam:ListPolicyVersions",
                  "iam:ListRolePolicies",
                  "iam:ListSSHPublicKeys",
                  "iam:ListSigningCertificates",
                  "iam:ListUserPolicies",
                  "iam:Upload*"
              ],
              "Effect": "Allow",
              "Resource": [
                  "*"
              ]
          },
          {
              "Action": [
                  "iam:GetRole",
                  "iam:ListRoles",
                  "iam:PassRole"
              ],
              "Effect": "Allow",
              "Resource": [
                  "arn:aws:iam::*:role/rds-monitoring-role",
                  "arn:aws:iam::*:role/ec2-sysadmin-*",
                  "arn:aws:iam::*:role/ecr-sysadmin-*",
                  "arn:aws:iam::*:role/lambda-sysadmin-*"
              ]
          },
          {
              "Sid": "VisualEditor0",
              "Effect": "Allow",
              "Action": "ec2:CreateNetworkInterfacePermission",
              "Resource": "arn:aws:ec2:*:*:network-interface/*",
              "Condition": {
                  "StringEquals": {
                  "ec2:Subnet": [
                      "arn:aws:ec2:region:account-id:subnet/subnet-*"
                  ],
                  "ec2:AuthorizedService": "codebuild.amazonaws.com"
                 }
              }
          }
      ],
      "Version": "2012-10-17"
}
POLICY
}
