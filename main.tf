data "aws_region" "current" {
}

resource "aws_iam_role_policy" "policy" {
  name   = var.role_name
  role   = var.role_id
  policy = data.aws_iam_policy_document.instance_profile_policy_doc.json
}

data "aws_iam_policy_document" "instance_profile_policy_doc" {
  statement {
    sid = "PutLogs"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    resources = [
      "arn:aws:s3:::${var.application_bucket_name}/logs/*",
    ]
  }
  statement {
    sid = "GetObjects"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.application_bucket_name}/*",
      "arn:aws:s3:::${var.netacuity_bucket}",
    ]
  }
  statement {
    sid = "LegacyBackupBucketPut"
    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]
    resources = formatlist("arn:aws:s3:::%s/*", var.legacy_s3_backup_buckets)

  }
  statement {
    sid = "AllowLifecycleAction"
    actions = [
      "autoscaling:CompleteLifecycleAction",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "AllowSSM"
    actions = [
      "ssm:DescribeAssociation",
      "ssm:GetDeployablePatchSnapshotForInstance",
      "ssm:GetDocument",
      "ssm:DescribeDocument",
      "ssm:GetManifest",
      "ssm:GetParameters",
      "ssm:ListAssociations",
      "ssm:ListInstanceAssociations",
      "ssm:PutInventory",
      "ssm:PutComplianceItems",
      "ssm:PutConfigurePackageResult",
      "ssm:UpdateAssociationStatus",
      "ssm:UpdateInstanceAssociationStatus",
      "ssm:UpdateInstanceInformation",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "SSMMessages"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "Ec2Messages"
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "CloudWatchMetrics"
    actions = [
      "cloudwatch:PutMetricData",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "EC2Status"
    actions = [
      "ec2:DescribeInstanceStatus",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "DirectoryService"
    actions = [
      "ds:CreateComputer",
      "ds:DescribeDirectories",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "CloudwatchLogs"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
    resources = [
      "*",
    ]
  }
  statement {
    sid = "S3Access"
    actions = [
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:GetObject",
      "s3:GetEncryptionConfiguration",
      "s3:AbortMultipartUpload",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
    ]
    resources = [
      "*",
    ]
  }
}
