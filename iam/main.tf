provider "aws" {
    region = "eu-west-2"
}

resource "aws_iam_user" "testuser"{
    name = "JD"
}

resource "aws_iam_policy" "custompolicy" {
    name = "GlacierEFSEC2"
    policy = file("./custom_policy.json")
}

resource "aws_iam_policy_attachment" "policy_bind" {
    name = "attachment"
    users = [aws_iam_user.testuser.name]
    policy_arn = aws_iam_policy.custompolicy.arn
}