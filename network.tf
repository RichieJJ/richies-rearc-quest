resource "aws_vpc" "rearc-quest-vpc" {
  cidr_block = "10.100.0.0/16"

  tags = {
    "Name" = "rearc-quest-vpc"
  }
}

data "aws_availability_zones" "rearc-quest-available-zones" {
  state = "available"
}

resource "aws_subnet" "rearc-quest-subnet-1" {
  vpc_id            = aws_vpc.rearc-quest-vpc.id
  cidr_block        = "10.100.1.0/24"
  availability_zone = data.aws_availability_zones.rearc-quest-available-zones.names[0]

  tags = {
    "Name" = "rearc-quest-subnet-1"
  }
}

resource "aws_subnet" "rearc-quest-subnet-2" {
  vpc_id            = aws_vpc.rearc-quest-vpc.id
  cidr_block        = "10.100.2.0/24"
  availability_zone = data.aws_availability_zones.rearc-quest-available-zones.names[1]

  tags = {
    "Name" = "rearc-quest-subnet-2"
  }
}

resource "aws_subnet" "rearc-quest-subnet-3" {
  vpc_id            = aws_vpc.rearc-quest-vpc.id
  cidr_block        = "10.100.3.0/24"
  availability_zone = data.aws_availability_zones.rearc-quest-available-zones.names[2]

  tags = {
    "Name" = "rearc-quest-subnet-3"
  }
}

resource "aws_internet_gateway" "rearc-quest-internet-gateway" {
  vpc_id = aws_vpc.rearc-quest-vpc.id
}

resource "aws_default_route_table" "rearc-quest-route-table" {

  default_route_table_id = aws_vpc.rearc-quest-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rearc-quest-internet-gateway.id
  }
}
