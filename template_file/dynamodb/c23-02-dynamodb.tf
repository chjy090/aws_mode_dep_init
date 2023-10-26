resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name             = "example"
  hash_key         = "TestTableHashKey"
  read_capacity    = 1
  write_capacity   = 1
  attribute {
    name = "TestTableHashKey"
    type = "S"
  }
}
