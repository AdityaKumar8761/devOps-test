resource "aws_lb" "alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet_id1, var.public_subnet_id2]

  tags = {
    Name = "terraform-alb"
  }
}


resource "aws_lb_target_group" "example" {
  name     = "terraform-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_target_group_attachment" "tgAttach" {
  target_group_arn = aws_lb_target_group.example.arn
  target_id        = var.ec2_instance_id
  port             = 8080
}



resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
target_group_arn = aws_lb_target_group.example.arn
  }
}