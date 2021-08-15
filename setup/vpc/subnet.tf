data "aws_availability_zones" "azs"{
     state = "available"
  }
  resource "aws_subnet" "web_subnet1" {
  vpc_id     = aws_vpc.main.id
cidr_block = "${cidrsubnet(var.cidr_block,8,2)}"
  availability_zone  = "${ data.aws_availability_zones.azs.names[0]}"
  map_public_ip_on_launch = "true"
tags = {
    Name = "${var.project_name}-${var.environment_name}-web-az-1"
  }
}
output "web_subnet1_id" {
    value = aws_subnet.web_subnet1.id
}


resource "aws_subnet" "app_subnet1" {
  vpc_id     = aws_vpc.main.id
cidr_block = "${cidrsubnet(var.cidr_block,8,6)}"
  availability_zone  = "${data.aws_availability_zones.azs.names[0]}"
tags = {
    Name = "${var.project_name}-${var.environment_name}-app-az-1"
  }
}




resource "aws_subnet" "db_subnet1" {
  vpc_id     = aws_vpc.main.id
cidr_block = "${cidrsubnet(var.cidr_block,8,3)}"
  availability_zone  = "${data.aws_availability_zones.azs.names[0]}"
tags = {
    Name = "${var.project_name}-${var.environment_name}-db-az-1"
  }
}
output "db_subnet1_id" {
    value = aws_subnet.db_subnet1.id
}



resource "aws_subnet" "db_subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${cidrsubnet(var.cidr_block,8,4)}"
  availability_zone  = "${ data.aws_availability_zones.azs.names[1]}"
tags = {
    Name = "${var.project_name}-${var.environment_name}-db-az-2"
  }
}
output "db_subnet2_id" {
    value = aws_subnet.db_subnet2.id
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
   Name = "${var.project_name}-${var.environment_name}-igw"
  }
}

resource "aws_route_table" "pubrt" {
  vpc_id = aws_vpc.main.id
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 tags = {

    Name = "${var.project_name}-${var.environment_name}-web-rt"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.web_subnet1.id
  route_table_id = aws_route_table.pubrt.id
}


resource "aws_eip" "nat" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.web_subnet1.id
}


resource "aws_route_table" "PrivateRoutetable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
 tags = {

    Name = "${var.project_name}-${var.environment_name}-nat-rt"
  }
}
resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.app_subnet1.id
  route_table_id = aws_route_table.prirt.id
}

resource "aws_route_table_association" "a5" {
  subnet_id      = aws_subnet.db_subnet1.id
  route_table_id = aws_route_table.prirt.id
}
resource "aws_route_table_association" "a6" {
  subnet_id      = aws_subnet.db_subnet2.id
  route_table_id = aws_route_table.prirt.id
}