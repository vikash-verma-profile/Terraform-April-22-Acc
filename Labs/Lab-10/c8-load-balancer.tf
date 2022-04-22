resource "aws_elb" "lb" {
  name ="lb"
  subnets = [ aws_subnet.vpc-subnet-1.id ]
    listener {
      instance_port=8000
      instance_protocol="http"
      lb_port=80
      lb_protocol="http"
    }

    #  listener {
    #   instance_port=8000
    #   instance_protocol="http"
    #   lb_port=443
    #   lb_protocol="https"
    #   ssl_certificate_id = 
    # }
    # health_check {
      
    # }
    instances = [aws_instance.my-ec2-vm.id]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout =  400
}