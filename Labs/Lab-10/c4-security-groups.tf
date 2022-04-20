resource "aws_security_group" "dev-vpc-sg" {
  name        = "dev-vpc-sg"
  description = "dev-vpc-sg"
  vpc_id = aws_vpc.vpc-dev.id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    self        = false
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all ip and ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = false
  }
}
