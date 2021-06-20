data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "AWS"
      identifiers = "arn:aws:iam::${var.aws_account_id}:root"
    }
  }
}

# create iam role
resource "aws_iam_role" "main" {
  name                 = "${var.name}-role"
  path                 = "/"
  max_session_duration = var.max_session_duration
  description          = var.role_description

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = local.tags
}
