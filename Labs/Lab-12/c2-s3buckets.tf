resource "aws_s3_bucket" "mys3bucket" {

  for_each = {
    "dev"  = "my-dapp-bucket-5528"
    # "qa"   = "my-qapp-bucket"
    # "stag" = "my-sapp-bucket"
    # "prod" = "my-papp-bucket"
  }
    bucket = "${each.key}-${each.value}" #dev-my-dapp-bucket
    tags = {
      Environment = each.key
      Bucketname="${each.key}-${each.value}"
    }
}

