variable "mysql_sg_id" {
    type = string
    default = ""
}
variable "backend_sg_id" {
    type = string
    default = ""
}
variable "frontend_sg_id" {
    type = string
    default = ""
}
variable "internet_user" {
    type = list(string)
}
variable "bastion_sg_id" {
    type = string
    default = ""
}
variable "ansible_sg_id" {
    type = string
    default = ""
}
variable "app_lb_sg_id" {
    type = string
    default = ""
}
variable "web_alb_sg_id" {
    type = string
    default = ""
}
variable "vpn_sg_id" {
    type = string
    default = ""
}