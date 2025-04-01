output "subnet_ids" {
  description = "생성된 Public 서브넷의 ID 목록"
  value       = aws_subnet.subnet[*].id
}

