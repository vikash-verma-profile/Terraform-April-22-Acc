terraform{
    required_version=">=1.0.0"
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~>3.0"
        }
    }
    #adding backend as s2 remote state storage
    backend "s3" {
      bucket = "terraform-backend-sample-551"
      key = "terraform.tfstate"
      region = "us-east-1"

      #for state locking
      #create a column name LockID 
      dynamodb_table = "terraform-dev-state-table"
    }
}
#Block 2--Provider block
provider "aws" {
  region = "us-east-1"
  profile = "default"
}

