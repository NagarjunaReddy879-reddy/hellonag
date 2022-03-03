terraform {
  backend "s3" {
    bucket = "helloreddy"
    key    = "myterraform-functions.state"
    region = "us-east-1"
    dynamodb_table = "myterraform-state-lock-dynamo"
    encrypt = "true"
  }
}