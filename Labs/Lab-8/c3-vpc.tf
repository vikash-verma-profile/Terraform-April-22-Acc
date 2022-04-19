#create VPC
resource "aws_vpc" "vpc-dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "vpc-dev"
  }
}

#create Subnets
resource "aws_subnet" "vpc-subnet-1" {
  vpc_id                  = aws_vpc.vpc-dev.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}
#Internet Gateway
resource "aws_internet_gateway" "vpc-dev-igw" {
  vpc_id = aws_vpc.vpc-dev.id
}
#Route table
resource "aws_route_table" "vpc-dev-route-table" {
  vpc_id = aws_vpc.vpc-dev.id
}
#route table and internet gateway
resource "aws_route" "vpc-dev-public-route" {
  route_table_id         = aws_route_table.vpc-dev-route-table.id
  gateway_id             = aws_internet_gateway.vpc-dev-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
#association between route table and subnet
resource "aws_route_table_association" "vpc-dev-public-route-table-association" {
  route_table_id = aws_route_table.vpc-dev-route-table.id
  subnet_id      = aws_subnet.vpc-subnet-1.id
}
