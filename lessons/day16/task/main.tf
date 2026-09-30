resource "aws_iam_user" "user" {
  for_each = { for user in local.users: user.first_name => user }
  name = lower("${substr(each.value.last_name,0,1)}${each.value.last_name}")
  path = "/users/"
  tags = {
    "Display name" = "${each.value.first_name} ${each.value.last_name}" 
    "Department" = each.value.department
    "Jobtitle" = each.value.job_title
  }
}

resource "aws_iam_user_login_profile" "name" {
  for_each = aws_iam_user.user
  user = each.value.name
  password_reset_required = true

  lifecycle {
    ignore_changes = [ password_reset_required, password_length ]
  }
}

resource "aws_iam_group" "Education" {
  name = "Education"
  path = "/groups/"
}

resource "aws_iam_group" "Engineers" {
  name = "Engineers"
  path = "/groups/"
}

resource "aws_iam_group" "Managers" {
  name = "Managers"
  path = "/groups/"
}

resource "aws_iam_group_membership" "education-group-membershi" {
  name = "education-group-membership"
  group = aws_iam_group.Education.name
  users = [
    for user in aws_iam_user.user: user.name if user.tags.Department == "Education"
  ]
}

# Add users to the Engineers group
resource "aws_iam_group_membership" "engineers_members" {
  name  = "engineers-group-membership"
  group = aws_iam_group.Engineers.name

  users = [
    for user in aws_iam_user.user : user.name if user.tags.Department == "Engineering"
  ]
}

resource "aws_iam_group_membership" "managers_members" {
  name  = "engineers-group-membership"
  group = aws_iam_group.Managers.name

  users = [
    for user in aws_iam_user.user : user.name if contains(keys(user.tags), "Jobtitle") && can(regex("Manger|CEO", user.tags.Jobtitle))
  ]
}

resource "aws_iam_policy" "policy" {
  name        = "example-policy"
  description = "An example policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "example-attach" {
  name       = "example-attachment"
  groups     = [aws_iam_group.Education.id]
  policy_arn = aws_iam_policy.policy.arn
}
