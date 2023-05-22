locals {
  lambda_ingest_zip_location = "outputs/ingest_func.zip"
  lambda_consume_zip_location = "outputs/consume_func.zip"
}

## KINESIS PART

resource "aws_kinesis_stream" "event_stream" {
  name             = "event_stream"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }

}

## S3 PART

resource "aws_s3_bucket" "consume-bucket" {
  bucket = "consume-bucket"

}

## INGEST LAMBDA PART

data "archive_file" "lambda_ingest" {
  type        = "zip"
  source_file = "ingest_func.py"
  output_path = local.lambda_ingest_zip_location
}

resource "aws_lambda_function" "ingest_func" {

  filename      = local.lambda_ingest_zip_location
  function_name = "ingest_func"
  role          = aws_iam_role.lambda_role.arn
  handler       = "ingest_func.lambda_handler"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

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


## CONSUME PART

data "archive_file" "lambda_consume" {
  type        = "zip"
  source_file = "consume_func.py"
  output_path = local.lambda_consume_zip_location
}

resource "aws_lambda_function" "consume_func" {

  filename      = local.lambda_consume_zip_location
  function_name = "consume_func"
  role          = aws_iam_role.lambda_role.arn
  handler       = "consume_func.lambda_handler"

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.8"

}

# SET TRIGGER FOR CONSUME FUNC
resource "aws_lambda_event_source_mapping" "consume_trigger" {
  event_source_arn = aws_kinesis_stream.event_stream.arn
  function_name    = aws_lambda_function.consume_func.function_name
  starting_position = "LATEST"
}



