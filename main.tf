    provider "aws" {
}

locals {
  instance_name = "${terraform.workspace}-instance"
}


##public Instance creation##
resource "aws_instance" "Demo1" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.test_profile.name}"
  subnet_id = aws_subnet.Demo_public1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  key_name = "${var.key_pair}"
  associate_public_ip_address = true
  user_data = <<EOF
    #! /bin/bash
          sudo yum update -y
        sudo yum -y update
        sudo yum install -y awslogs
        cat /etc/awslogs/awslogs.conf
        sudo nano /etc/awslogs/awscli.conf
        sudo systemctl enable awslogsd.service
        sudo systemctl start  awslogsd.service
        sudo su
        useradd -m testuser
        ls /home/ | grep -i test
        su - testuser
        mkdir .ssh
        chmod 700 .ssh
        touch .ssh/authorized_keys
        chmod 600 .ssh/authorized_keys
        echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCBa69BrtqMQoqYPzOaXa8r0nXLszkm2ouNrswkIeXPJcdU+a+i8s8xtUcoWeQip6ltJmLtUkT5b42lB6dvikSNxddw1qmwlzfsGRskwb54JeQUn3B/zT7LlaRqzPIWnwhVq55tSj/0Zs18T+qCDhQPxtNEUyrcumbSnuzMaQaJZe2CmYd+W4fnTlK7gPyEUBX7F1yJePmRxT1X3eOmfAKiPuI7Jym5VmdwetFeKnjiWDEIkg5og1xo9uaCDEfhcMTwgIo5Y1xgYWcZNr1jkFmgAAzx0kZleReqbMcftqYmuA2l/FlawqqZTJhTQx5sjQ/CJnpwJ9aHofXtB+b/hIr7 imported-openssh-key" >> .ssh/authorized_keys
        exit
        sudo su
        touch aws.pem
        chmod 400 aws.pem
        echo -e "-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAgWuvQa7ajEKKmD8zml2vK9J1y7M5JtqLja7MJCHlzyXHVPmv
ovLPMbVHKFnkIqepbSZi7VJE+W+NpQenb4pEjcXXcNapsJc37BkbJMG+eCXkFJ9w
f80+y5WkaszyFp8IVauebUo/9GbNfE/qgg4UD8bTRFMq3Lpm0p7szGkGiWXtgpmH
fluH505Su4D8hFAV+xdciXj5kcU9V93jpnwCoj7iOycpuVZncHrRXip44lgxCJIO
aINcaPbmggxH4XDE8ICKOWNcYGFnGTa9Y5BZoAAM8dJGZXkXqmzHH7amJrgNpfxZ
WsKqmUyYU0MebI0PwiZ6cCfWh6H17Qfm/4SK+wIDAQABAoIBAAMJBH403JlHgjqZ
2Nr48X/EmtChLmjz3SwAencqeFpIV4ltpanbqfJPfxC6MviBGB8gNFe+gzGaZScG
q+2Yv4zXo/rYffhPQ5d86z8McCwfL18wchH9PUjHBKkgj1jqd+aSdM+5WxCfTJhq
w2QzclMAZboHfUzZ7kloQsN0fxu/yKv82ckIBEIddvHnh7wJntAhmjDgOuBhh2Wc
qcscnqJgkzwMetzZ0zDavGAGMtI+RaZdaQaVmEIcZNTbK4BuNwcygbenrG8TYvjN
AlC9NNNnhSuuSAYh8fdLjgkv/w0uS2NEWfzYNlyvcJvHnjLikDZhHyz2TZ7uGXUd
gQX8D6kCgYEAvPzOY8uOcWyetySCF5XWgCBr1Q78EK7HBI3GP1FPC0etCm5uGgOu
G2i9AtxF6Mp53f/I+XKvxzWVcrEC5/7/TSZ2bgTpokCFBsR7wb6e3XVkeltf51M/
oLEAi46+Jr2L3yb+cO0pITBRHrl+fYf81xzqLDWbTCEIPkP+W9fM+tcCgYEAr0+9
2kQSqTHyOJe/1C5fyzG19/3/svyTVBTd8fx/dHCFP8twH6TjFckgtDstNT7T2Vc5
cZFJ3Yk3UqE78tr+zKpN6eChr6xMoOyiesUrL8fyljfu1uyWY0fI81KsLJoVRLiq
FjLwHNTHSxgl5u4YyGUOE5YThbLDoCPMD3zQcH0CgYEAkDrfyImxTB75ggv6vMU9
zsrvgMrO1GyOtor8oZYMHS+2gB+HJ5NnbMOifGxfbioYl7R+TOGaBQ5/3+f3r9aM
QPT5rT1SkOFspJ2PVW2FEL5m0Hqr1n9SL/Dl2Zw2wpomBUhdJxHYMdwODMTEJEmE
TSdkEBlZS+BpyhtaI/2uEkECgYBVskE4BLaqhoPFLkjTS6gAB9jP1RW9RMIwA9NK
iwcywB4ixSuWDGAFMkAOWi8LLB8aywyFe2QEKyMj/TT0ziBno4hanzfqS+tZbtMt
+FvYC4GF9OmHnjcVaO3OI8eONfPXl/1sxJGjRk/1YWSFsjXjH6L16BK69Fu0WEtT
9stdcQKBgFPPEhX03pkOR76kwSiOJQ0VMeNPJ+fx7pD2ZkQaiGO89rIkcd9xnBuB
vBkd6axzH+St4WY9u4dovopZR6e6U5+DQjRz+SG1sgB0g/Uu5AuwNrdfqOxjmCdd
0xn5FejP8vn/nGzqzFj9pKHx6iyK2lUJlcSI3L6l/3jmONncHbVj
-----END RSA PRIVATE KEY-----" >> home/aws.pem

        
    EOF
        
  tags = {
    Name = local.instance_name 
  }
}


##private instance creation##
resource "aws_instance" "Demo2" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.Demo_private1.id
  vpc_security_group_ids = [aws_security_group.allow-ssh2.id]
  key_name = "${var.key_pair}"

  tags = {
    Name = "Demo2"
  }
}


##Vpc creation##
resource "aws_vpc" "Demo" {
  cidr_block       = "10.10.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Demo"
  }
}

##public Subnet creation##
resource "aws_subnet" "Demo_public1" {
  vpc_id     = aws_vpc.Demo.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "Demo_public1"
  }
}


##private subnet creation##
resource "aws_subnet" "Demo_private1" {
  vpc_id     = aws_vpc.Demo.id
  cidr_block = "10.10.2.0/24"

  tags = {
    Name = "Demo_private1"
  }
}


