# INSTALL DEPENDENCIES

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${var.lambda_root}/requirements.txt -t ${var.lambda_root}/"
  }
  
  triggers = {
    dependencies_versions = filemd5("${var.lambda_root}/requirements.txt")
    source_versions = filemd5("${var.lambda_root}/consume_func_db.py")
  }
}

data "archive_file" "lambda_consume_db" {
  depends_on = [null_resource.install_dependencies]
  excludes   = [
    "__pycache__",
    "venv",
    "consume_func.py",
    "ingest_func.py"
  ]

  source_dir  = var.lambda_root
  output_path = local.lambda_consume_db_zip_location
  type        = "zip"
}


## CONSUME PART

resource "aws_lambda_function" "consume_func_db" {
  depends_on = [aws_db_instance.db_storage]
  filename      = data.archive_file.lambda_consume_db.output_path
  function_name = "consume_func_db"
  role          = aws_iam_role.lambda_role.arn
  handler       = "consume_func_db.lambda_handler"

  source_code_hash = data.archive_file.lambda_consume_db.output_base64sha256

  runtime = "python3.10"

  environment {
    variables = {
      DB_INSTANCE_ADDRESS = aws_db_instance.db_storage.address,
      username = var.username
      password = var.password
      db_name = var.db_name
    }
  }

  vpc_config {
  subnet_ids         = [var.subnet_id]
  security_group_ids = [var.security_group_id]
  }

}

# SET TRIGGER FOR CONSUME FUNC
resource "aws_lambda_event_source_mapping" "consume_db_trigger" {
  event_source_arn = aws_kinesis_stream.event_stream.arn
  function_name    = aws_lambda_function.consume_func_db.function_name
  starting_position = "LATEST"
}
