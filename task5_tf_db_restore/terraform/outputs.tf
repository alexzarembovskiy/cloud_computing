output "ingest_func_url" {
  description = "Ingest function URL to invoke it"
  value       = aws_lambda_function_url.ingest_func_url.function_url
}

output "db_endpoint" {
  description = "Database endpoint to connect to it"
  value       = aws_db_instance.db_storage.address
}