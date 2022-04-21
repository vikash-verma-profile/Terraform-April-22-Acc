#create EC2 Instance
resource "aws_instance" "my-ec2-vm" {
  ami                    = "ami-03ededff12e34e59e"
  instance_type          = "t2.micro"
  key_name               = "terraform-key"
  vpc_security_group_ids = [aws_security_group.dev-ssh.id]
  user_data = file("apache-install.sh")
  tags = {
    "Name" = "web-4"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    password    = ""
    private_key = file("private-key/terraform-key.pem")
  }

  #file provisioner
  provisioner "file" {
    source="apps/index.html"
    destination = "/tmp/index.html"
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 120",
  #     "sudo cp /tmp/index.html  /var"
  #   ]
  # }

  # provisioner "local-exec" {
  #   command = "echo ${aws_instance.my-ec2-vm.private_ip} >>sample.txt"
  #   working_dir = "apps/"
  # }
}
