output "alb_hostname" {
  value = aws_lb.main.dns_name
  description = "value"
}


output "cluster" {
  value = aws_ecs_service.main
}

