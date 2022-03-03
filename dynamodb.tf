#resource "aws_dynamodb_table" "myterraform-state-lock-dynamo" {
#  name           = "myterraform-state-lock-dynamoo"
#  hash_key       = "LockID"
#  read_capacity  = 20
#  write_capacity = 20
#   attribute {
#    name = "LockID"
#    type = "S"
#   }
#}