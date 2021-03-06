resource "aws_lb" "test" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALBSG.id]
  subnets = var.subnets
}

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.test.arn
  port              = var.application_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances.arn
  }
}

resource "aws_lb_target_group" "instances" {
  name = "alb"
  target_type = "instance"
  port        = var.application_port
  protocol    = "HTTP"
  vpc_id      = var.vpc

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 3
    interval            = 5
    protocol = "HTTP"
    port = var.application_port
    path = "/"
  }

}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = var.instance_id
  port             = var.application_port
}