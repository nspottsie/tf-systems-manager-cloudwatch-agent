resource "aws_security_group" "windows_instance" {
  name        = "bastion"
  description = "Allow RDP traffic from known public IPs to the Bastion"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = "${var.whitelisted_ips}"
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
