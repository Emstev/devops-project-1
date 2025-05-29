variable "lb_target_group_name" {}
variable "lb_target_group_port" {}
variable "lb_target_group_protocol" {}
variable "vpc_id" {}
variable "ec2_instance_id" {}

output "dev_proj_1_lb_target_group_arn" {
  value = aws_lb_target_group.dev_proj_1_lb_target_group.arn
}

resource "aws_lb_target_group" "dev_proj_1_lb_target_group" {
  name     = "dev-proj-1-lb-target-group"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "dev_proj_1_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.dev_proj_1_lb_target_group.arn
  target_id        = var.ec2_instance_id
  port             = 5000
}
