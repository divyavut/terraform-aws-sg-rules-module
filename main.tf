# allow connections on 3306 port from the instances which are connected to backend sg
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = var.backend_sg_id
  security_group_id = var.mysql_sg_id
}

# allow connections on 8080 port from the instances which are connected to frontend sg
resource "aws_security_group_rule" "backend_frontend" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = var.frontend_sg_id
  security_group_id = var.backend_sg_id
}

# allow connections on 80 port from the instances which are connected to frontend sg
resource "aws_security_group_rule" "frontend_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.frontend_sg_id
}

# allow connections on 22 port from the bastion host to mysql server
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.mysql_sg_id
}
# allow connections on 22 port from the bastion host to backend server
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.backend_sg_id
}
# allow connections on 22 port from the bastion host to frontend server
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.frontend_sg_id
}


# allow connections on 22 port from the ansible host to mysql server
resource "aws_security_group_rule" "mysql_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.ansible_sg_id
  security_group_id = var.mysql_sg_id
}
# allow connections on 22 port from the ansible host to backend server
resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.ansible_sg_id
  security_group_id = var.backend_sg_id
}
# allow connections on 22 port from the ansible host to frontend server
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.ansible_sg_id
  security_group_id = var.frontend_sg_id
}

# allow connections on 22 port from the public host to ansible server
resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.ansible_sg_id
}
# allow connections on 22 port from the public host to ansible server
resource "aws_security_group_rule" "Bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.bastion_sg_id
}

