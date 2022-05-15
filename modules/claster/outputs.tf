output "alb_dns_name" {
  value       = aws_alb.test.dns_name
  description = "Domain name ALB"
}
output "target_group_arns" {
  value       = aws_alb_target_group.asg-target-group.arn
  description = ""
}
