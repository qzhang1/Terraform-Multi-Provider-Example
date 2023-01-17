provider "aws" {
  region     = "us-east-1"
  access_key = "insert your access key"
  secret_key = "insert your secret key"
  version = "3.55"
}

provider "aws" {
  alias = "awsv416"
  region     = "us-east-1"
  access_key = "insert your access key"
  secret_key = "insert your secret key"
  version = "4.16"
}