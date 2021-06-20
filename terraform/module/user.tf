# create iam user and add user into main group
resource "aws_iam_user" "main" {
  name = var.name
  path = "/"

  tags = local.tags
}

resource "aws_iam_group_membership" "main" {
  name = var.name

  users = [
    aws_iam_user.main.name,
  ]

  group = aws_iam_group.main.name

  depends_on = [
    aws_iam_group.main,
  ]
}
