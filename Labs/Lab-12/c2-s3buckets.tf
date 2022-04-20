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

locals {
  users=toset([ "Vikash1" , "Vikash2" , "Vikash3" ])
}
#toset for set of strings
resource "aws_iam_user" "users" {
  for_each = local.users
  name = each.key
}


resource "aws_iam_user_policy" "test_policy" {
depends_on = [
  aws_iam_user.users
]
 for_each = local.users
  name   = "test-policy"
  user   = "${each.key}" #"vikash"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
 EOF
}
