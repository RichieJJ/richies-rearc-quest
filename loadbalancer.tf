resource "aws_alb" "rearc-quest-alb" {
  name               = "rearc-quest-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.rearc-quest-alb-sg.id]
  subnets            = [aws_subnet.rearc-quest-subnet-1.id, aws_subnet.rearc-quest-subnet-2.id, aws_subnet.rearc-quest-subnet-3.id]
}

resource "aws_alb_target_group" "rearc-quest-target-group" {
  name        = "rearc-quest-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.rearc-quest-vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  depends_on = [aws_alb.rearc-quest-alb]
}

resource "aws_alb_listener" "rearc-quest-http-listener" {
  load_balancer_arn = aws_alb.rearc-quest-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    # type = "redirect"

    # redirect {
    #   port        = "443"
    #   protocol    = "HTTPS"
    #   status_code = "HTTP_301"
    # }

    target_group_arn = aws_alb_target_group.rearc-quest-target-group.arn
    type             = "forward"
  }
}

resource "aws_instance" "rearc-quest-vm" {
  ami                    = "ami-0aa7d40eeae50c9a9"
  instance_type          = "t2.micro"

  tags = {
    name = "rearc-quest-vm"
  }  
}


