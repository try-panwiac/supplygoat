provider "aws" {
  region = "us-east-1"
}

resource "aws_lambda_function" "example_lambda" {
  function_name    = "example_lambda_function"
  handler          = "index.handler"
  runtime          = "provided.al2"
  role             = aws_iam_role.lambda_exec.arn
  timeout          = 15
  memory_size      = 256
  package_type     = "Image"
  image_uri        = "node"
}

resource "aws_iam_role" "lambda_exec" {
  name = "example-lambda-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_exec.name
}
