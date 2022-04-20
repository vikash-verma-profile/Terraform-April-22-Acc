#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami="ami-03ededff12e34e59e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  #availability_zone = "us-east-1b"
  tags = {
    "Name" = "web-3"
  }
  lifecycle {
    #create_before_destroy = true
    #prevent_destroy = false
    ignore_changes = [
      tags,instance_type
    ]
  }
}
