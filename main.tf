#main.tf

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "ec2_example" {
  count                  = var.instance_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.main.id]

  # file provisioner - 
  # It will copy the "startup.sh" to remote machine
  provisioner "file" {
    source      = var.source_script
    destination = var.destination_script
  }

  # connection -
  # This block will be used for ssh connection to initiate the copy
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.ec2_user
    private_key = file(var.private_key)
    timeout     = "8m"
  }

  tags = {
    Name = "${var.env_prefix}-EC2-${var.instance_count}"
  }


  # remote-exec - 
  # Execute the "startup.sh" script copied using "file" provisoner
  provisioner "remote-exec" {
    inline = [
      "chmod +x ${var.destination_script}",
      "sh ${var.destination_script}"
    ]
  }

}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

# aws_key_pair -
# You need to generate the public as well as private key using - ssh-keygen
# Place the public key here 
resource "aws_key_pair" "deployer" {
  key_name   = "${var.env_prefix}-KP"
  public_key = var.public_key
  tags = {
    Name = "${var.env_prefix}-KP"
  }
}
