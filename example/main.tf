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
    yor_trace = "4d8573c1-2712-481e-9699-b2de7a200f02"
  }
}

