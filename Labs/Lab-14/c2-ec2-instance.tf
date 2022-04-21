#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami="ami-03ededff12e34e59e"
  instance_type = "t2.micro"
  key_name = "terraform-key"
  vpc_security_group_ids = [ aws_security_group.dev-ssh.id ]
  tags = {
    "Name" = "web-3"
  }

  connection {
    type="ssh"
    host=self.public_ip
    user = "ec2-user"
    password = ""
    private_key = file("private-key/terraform-key.pem")
  }

  #file provisioner
  provisioner "file" {
    source="apps/index.html"
    destination = "/tmp/index.html"
  }

}
