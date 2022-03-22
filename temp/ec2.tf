resource "aws_instance" "srv01" {
  ami                           = data.aws_ami.ubuntu20.id
  instance_type                 = var.instanceType
  subnet_id                     = aws_subnet.subpub1a.id
  associate_public_ip_address   = true
  disable_api_termination       = false
  key_name                      = aws_key_pair.ubuntu_jenkins.key_name
  vpc_security_group_ids        = [aws_security_group.jenkins_web.id]

  root_block_device {
    volume_size                 = "${var.ebsSize}"
    volume_type                 = "gp2"
    delete_on_termination       = true
  }

  user_data              = "${file("jenkins.sh")}"
  tags                          = var.tags
}

resource "aws_key_pair" "ubuntu_jenkins" {
  key_name   = "ubuntu_jenkins"
  public_key = "ssh-rsa AAAAB3NzaC1yc"

  tags       = var.tags
}
