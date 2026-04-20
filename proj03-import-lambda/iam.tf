import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-00ep0fbw"
}

import {
  to = aws_iam_policy.lambda_execution_policy
  id = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/service-role/AWSLambdaBasicExecutionRole-8771dc85-7489-45c2-949a-dd2fe87cbb5e"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_policy" "lambda_execution_policy" {
  name = "AWSLambdaBasicExecutionRole-8771dc85-7489-45c2-949a-dd2fe87cbb5e"
  path = "/service-role/"
  policy = jsonencode({
    Statement = [{
      Action   = "logs:CreateLogGroup"
      Effect   = "Allow"
      Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      }, {
      Action   = ["logs:CreateLogStream", "logs:PutLogEvents"]
      Effect   = "Allow"
      Resource = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${aws_cloudwatch_log_group.lambda.arn}:*"]
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  name = "manually-created-lambda-role-00ep0fbw"
  path = "/service-role/"
}

resource "aws_iam_role_policy_attachment" "lambda_execution" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}