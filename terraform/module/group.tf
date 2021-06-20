# create iam group and polices attached
data "aws_iam_policy_document" "group_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    resources = [
      aws_iam_role.main.arn,
    ]
  }
}

resource "aws_iam_policy" "main" {
  name_prefix = "${var.name}-policy"
  policy      = data.aws_iam_policy_document.group_policy.json

  tags = local.tags

  depends_on = [
    aws_iam_role.main,
  ]
}

resource "aws_iam_group" "main" {
  name = "${var.name}-group"
}

resource "aws_iam_group_policy_attachment" "main" {
  group      = aws_iam_group.main.name
  policy_arn = aws_iam_policy.main.arn

  depends_on = [
    aws_iam_group.main,
    aws_iam_policy.main,
  ]
}
