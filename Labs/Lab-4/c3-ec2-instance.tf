#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami=var.ec2_ami_id
  instance_type = "t2.micro"
  count = var.ec2_instace_count
  tags = {
    "Name" = "myec2vm"
  }
}
