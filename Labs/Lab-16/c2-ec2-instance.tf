#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dev-ssh.id]
  tags = {
    "Name" = "web-new"
  }
}
