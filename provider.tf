provider "aws" {
  region     = "us-east-1"
  version    = "3.55"
  access_key = "insert your access key"
  secret_key = "insert your secret key"
}

provider "aws" {
  alias = "awsv416"
  region     = "us-east-1"
  version    = "4.16"
  access_key = "insert your access key"
  secret_key = "insert your secret key"
}