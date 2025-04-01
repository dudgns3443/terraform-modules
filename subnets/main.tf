resource "aws_subnet" "subent" {
  count             = length(var.subnets)
  vpc_id            = var.vpc_id
  cidr_block        = var.subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = var.is_public

  tags = merge(
    var.tags,
    {
      Name = var.is_public? "${var.name_prefix}-public-${var.azs[count.index]}" : "${var.name_prefix}-private-${var.azs[count.index]}"
    }
  )
}


# 라우팅 테이블 (NAT Gateway, IGW를 통한 기본 라우트)
resource "aws_route_table" "route_table" {
  count = length(var.gateway_ids)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_ids
  }

  tags = merge(
    var.tags,
    {
      Name = var.is_public ? "${var.name_prefix}-public-rt" : "${var.name_prefix}-private-rt-${var.azs[count.index]}"
    }
  )
}

# 서브넷과 라우팅 테이블 연결
resource "aws_route_table_association" "rt_assoc" {
  count          = length(var.subnets)
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = var.is_public ? aws_route_table.route_table[0].id : aws_route_table.route_table[count.index].id
}
