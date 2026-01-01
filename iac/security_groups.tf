resource "aws_security_group" "instance_rules" {
  name        = "instance_rules"
  description = "EC2 instance security rules"

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "instance_rules"
  }

}

resource "aws_security_group_rule" "allow_all_egress" {
  security_group_id = aws_security_group.instance_rules.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

}
resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = aws_security_group.instance_rules.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
}

