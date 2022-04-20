# resource "aws_s3_bucket" "mys3bucket" {

#Map
# #   for_each = {
# #     "dev"  = "my-dapp-bucket-5528"
# #     # "qa"   = "my-qapp-bucket"
# #     # "stag" = "my-sapp-bucket"
# #     # "prod" = "my-papp-bucket"
# #   }
# #"${each.key}-${each.value}"
#     bucket =  "dev-my-dapp-bucket-5528"
#     # tags = {
#     #   Environment = each.key
#     #   Bucketname="${each.key}-${each.value}"
#     # }
# }

#toset for set of strings
resource "aws_iam_user" "users" {
  for_each = toset([ "Vikash1" , "Vikash2" , "Vikash3" ])
  name = each.key
}

