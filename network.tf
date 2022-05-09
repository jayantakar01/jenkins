# creation of internet gateway#
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.Demo.id
    tags = {
        Name = "igw"
    }
}

# Public routes
resource "aws_route_table" "public_route1" {
    vpc_id = aws_vpc.Demo.id

    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.igw.id 
    }

    tags = {
        Name = "public_route1"
    }
}
resource "aws_route_table_association" "public_Demo1"{
    subnet_id = aws_subnet.Demo_public1.id
    route_table_id = aws_route_table.public_route1.id
}


## private route ##
resource "aws_route_table" "private_route1" {
    vpc_id = aws_vpc.Demo.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway.id 
    }

    tags = {
        Name = "private_route1"
    }
}
resource "aws_route_table_association" "private_subnet1"{
    subnet_id = aws_subnet.Demo_private1.id
    route_table_id = aws_route_table.private_route1.id
}



# NAT Gateway to allow private subnet to connect out the way
resource "aws_eip" "nat_gateway" {
    vpc = true
}
resource "aws_nat_gateway" "nat-gateway" {
    allocation_id = aws_eip.nat_gateway.id
    subnet_id     = aws_subnet.Demo_public1.id

    tags = {
    Name = "VPC Demo - NAT"
    }
}
