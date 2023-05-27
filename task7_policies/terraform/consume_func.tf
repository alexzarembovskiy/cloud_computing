## CONSUME PART

data "archive_file" "lambda_consume" {
  type        = "zip"
  source_file = "${var.lambda_root}/consume_func.py"
  output_path = local.lambda_consume_zip_location
}

resource "aws_lambda_function" "consume_func" {

  filename      = local.lambda_consume_zip_location
  function_name = "consume_func"
  role          = aws_iam_role.lambda_role.arn
  handler       = "consume_func.lambda_handler"

  source_code_hash = data.archive_file.lambda_consume.output_base64sha256

  runtime = "python3.10"

}

# SET TRIGGER FOR CONSUME FUNC
resource "aws_lambda_event_source_mapping" "consume_trigger" {
  event_source_arn = aws_kinesis_stream.event_stream.arn
  function_name    = aws_lambda_function.consume_func.function_name
  starting_position = "LATEST"
}