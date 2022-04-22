#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  tags = {
    "Name" = "myec2vm"
  }
}
