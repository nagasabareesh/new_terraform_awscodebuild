provider "aws" {
    region = "us-east-1"
    secret_key = ""
    access_key = ""
}

terraform {
    backend "s3"{
        encrypt = false
        bucket = "trraform-awscodebuild-sample"
        dynamodb_table = "tf-state-lock-dynamo"
        key = "path/path/terraform-tfstate"
        region = "us-east-1"
    }
}

resource "aws_vpc" "tf_test" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {
        "Name" = "tf_test"
    }  
}

resource "aws_subnet" "subnet-tf-public" {
  vpc_id = aws_vpc.tf_test.id
  cidr_block =  "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "subnet-tf-public"
  }
}

resource "aws_subnet" "subnet-tf-private" {
  vpc_id = aws_vpc.tf_test.id
  cidr_block =  "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "subnet-tf-private"
  }
}