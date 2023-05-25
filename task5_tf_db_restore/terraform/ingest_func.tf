
## INGEST LAMBDA PART

data "archive_file" "lambda_ingest" {
  type        = "zip"
  source_file = "${var.lambda_root}/ingest_func.py"
  output_path = local.lambda_ingest_zip_location
}

resource "aws_lambda_function" "ingest_func" {

  filename      = local.lambda_ingest_zip_location
  function_name = "ingest_func"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ingest_func.lambda_handler"

  source_code_hash = data.archive_file.lambda_ingest.output_base64sha256

  runtime = "python3.10"

}

## URL FOR INGEST FUNC
resource "aws_lambda_function_url" "ingest_func_url" {
  function_name      = aws_lambda_function.ingest_func.function_name
  authorization_type = "AWS_IAM"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}






