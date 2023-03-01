resource "aws_dynamodb_table" "table" {

  name           = var.name
  billing_mode   = "PROVISIONED"
  # kms_key_arn = var.kms_arn
  hash_key       = var.hash_key
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  
  attribute {
    name = var.hash_key
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }


  tags = {
    Name        = var.name
    Environment = var.env
  }
}



