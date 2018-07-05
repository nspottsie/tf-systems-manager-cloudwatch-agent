resource "aws_eip" "windows_instance" {
  instance = "${aws_instance.windows_instance.id}"
  vpc      = true
}

resource "aws_instance" "windows_instance" {
  ami = "${data.aws_ami.amazon_windows_2012_r2_base.id}"
  instance_type = "m4.large"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = ["${aws_security_group.windows_instance.id}"]
  subnet_id = "${var.subnet_id}"
  iam_instance_profile = "${aws_iam_instance_profile.systems_manager_profile.name}"

  tags {
    Name = "TestWindowsInstance"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = true
  }
}
