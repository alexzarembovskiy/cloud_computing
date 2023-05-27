locals {
  lambda_ingest_zip_location = "${var.outputs_root}/ingest_func.zip"
  lambda_consume_zip_location = "${var.outputs_root}/consume_func.zip"
  lambda_consume_db_zip_location = "${var.outputs_root}/consume_func_db.zip"
}
