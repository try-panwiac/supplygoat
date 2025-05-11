resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group for SSH access"

  ingress {
    from_port   = local.ssh_port
    to_port     = local.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_org   = "try-panwiac"
    git_repo  = "supplygoat"
    yor_trace = "14928ea6-a21d-4a15-a97f-f25c2cd6bc8e"
  }
}

