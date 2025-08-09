# create VPC and CIDR block

resource "aws_vpc" "vpc_name" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    tags = {
        Name = "dev-vpc"    
    }
}

# create subnet - 1 public 1 private

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc_name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a" 
    tags = {
        Name = "dev_public_subnet"
    }
    }

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.vpc_name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev_private_subnet" 
    }
}

# create internet gateway

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc_name.id
    tags = {
        Name = "dev-igw"
    }
}

# create route table 

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.vpc_name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "dev_route_table"
    }
}
# associate the route table with the public subnet.

resource "aws_route_table_association" "public_subnet_association" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rt.id
}

# associate the route table with the private subnet.

# create NAT gateway
# to create NAT gateaway elasctip ip is requires so first create an elastic IP resource block


resource "aws_eip" "eip_nat" {
   # vpc = true 
    tags = {
        Name = "dev_eip_nat"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.eip_nat.id
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "dev_nat_gateway"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.vpc_name.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }
}


resource "aws_route_table_association" "private_subnet_association" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.private_rt.id
}


#create security group

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.vpc_name.id
    name = "dev_sg"
    description = "Security group for dev environment"

    ingress {
        description = "allow SSH access"
        from_port = 22
        to_port = 22
        protocol ="tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        description = "allow http access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "allow all outbound traffic"
        from_port =0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
 
# create EC2 instance

resource "aws_instance" "ec2_instance" {
    ami = "ami-0de716d6197524dd9" # replace with a valid AMI ID
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    associate_public_ip_address = true
    tags = {
        name = "dev_ec2_instance"
    }
}