module "dynamo" {

  source = "git::git@github.com:platformbuilders/builders-aws-dynamo-terraform-module.git"

  name           = "access_manager_test"
  hash_key       = "test"
  read_capacity  = 20
  write_capacity = 20
  env            = "development"

}

module "kms" {

  source = "git::git@github.com:platformbuilders/builders-aws-kms-terraform-module.git"

  kms_key_name        = "kms-test"
  kms_key_description = "chave de criptografia do access manager"
  env                 = "development"


}

data "archive_file""zip_the_python_code"{
  type = "zip"
  source_dir = "${path.module}/python-test/"
  output_path = "${path.module}/python-test/hello-python.zip"
}

module "lambda_funciton" {
  source = "git::git@github.com:platformbuilders/builders-aws-lambda-terraform-module.git"
  filename      = "${path.module}/python-test/hello-python.zip" 
  function_name = "lambda-test"
  # function_description   = "função lambda teste"
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.9"
  # sqs_arn = aws_sqs_queue.sqs.arn
  api_name = "apigw-test"
  api_integration_http_method = "POST"
  api_auth = "NONE"
  environment = "development"
}

module "sqs" {

  source = "git::git@github.com:platformbuilders/builders-aws-sqs-terraform-module.git"

  name                      = "sqs-test"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  env                       = "development"
  function_name = "lambda-test"

}

