# allow connections on 3306 port from the instances which are connected to backend sg
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = var.backend_sg_id
  security_group_id = var.mysql_sg_id
}
# backend allow connections on 8080 port from only the application load balancer
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = var.app_lb_sg_id
  security_group_id = var.backend_sg_id
}
# app_lb allow connections on 80 port from only frontend server
resource "aws_security_group_rule" "app_lb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = var.frontend_sg_id
  security_group_id = var.app_lb_sg_id
}
# frontend allow connections on 80 port from only web load balancer 
resource "aws_security_group_rule" "frontend_web_lb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = var.web_alb_sg_id
  security_group_id = var.frontend_sg_id
}
# web loadbalancer allow connections on 80/443 port from users(internet)
resource "aws_security_group_rule" "web_lb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.web_alb_sg_id
}

#  mysql server allow connections on 3306 port from the bastion host 
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.mysql_sg_id
}
# backend server allow connections on 22 port from the bastion host 
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.backend_sg_id
}
# backend server allow connections on 8080 port from the bastion host 
resource "aws_security_group_rule" "backend_bastion_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.backend_sg_id
}
# application load balancer allow connections on 80 port from the bastion host 
resource "aws_security_group_rule" "app_lb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.app_lb_sg_id
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
# frontend server allow connections on 80 port from the bastion host 
resource "aws_security_group_rule" "frontend_bastion_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = var.bastion_sg_id
  security_group_id = var.frontend_sg_id
}
#  bastion server allow connections on 22 port from the public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.bastion_sg_id
}

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
# vpn allow connections on 22 port from the public
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
   cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.vpn_sg_id
}
# vpn allow connections on 443 port from the public
resource "aws_security_group_rule" "vpn_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.vpn_sg_id
}
# vpn allow connections on 943 port from the public
resource "aws_security_group_rule" "vpn_public_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.vpn_sg_id
}
# vpn allow connections on 1194 port from the public
resource "aws_security_group_rule" "vpn_public_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks      = [join("", var.internet_user)]
  security_group_id = var.vpn_sg_id
}
# application load balancer allow connections on 80 port from vpn
resource "aws_security_group_rule" "app_lb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = var.vpn_sg_id
  security_group_id = var.app_lb_sg_id
}
# backend allow connections on 80 port from vpn
resource "aws_security_group_rule" "backend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = var.vpn_sg_id
  security_group_id = var.backend_sg_id
}

# backend allow connections on 8080 port from vpn
resource "aws_security_group_rule" "backend_vpn_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = var.vpn_sg_id
  security_group_id = var.backend_sg_id
}
# # allow connections on 22 port from the public host to ansible server
# resource "aws_security_group_rule" "ansible_public" {
#   type              = "ingress"
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   cidr_blocks      = [join("", var.internet_user)]
#   security_group_id = var.ansible_sg_id
# }
# allow connections on 22 port from the public host to ansible server
#   


