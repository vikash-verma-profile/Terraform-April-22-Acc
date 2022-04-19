#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami=var.ec2_ami_id
  instance_type = "t2.micro"
  # count = var.ec2_instace_count
  key_name = "terraform-key"
  subnet_id = aws_subnet.vpc-subnet-1.id
  vpc_security_group_ids = [ aws_security_group.dev-vpc-sg.id ]
  tags = {
    "Name" = "myec2vm"
  }
}
