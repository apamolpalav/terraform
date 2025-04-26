provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_security_group" "main" {
  name = "${var.env_prefix}_security_group"
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
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 5432
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 5432
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "${var.env_prefix}_${var.key_name}"
  public_key = var.public_key
}


resource "aws_instance" "practice_ec2" {
  count = var.ec2_instance_count

  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name               = aws_key_pair.deployer.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

  # file provisioner - 
  # It will copy the "startup.sh" to remote machine
  provisioner "file" {
    source      = "${var.ec2_source_script_path}${var.ec2_source_script_name}"
    destination = "${var.ec2_destination_script_path}${var.ec2_destination_script_name}"
  }

  # connection -
  # This block will be used for ssh connection to initiate the copy
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.ec2_user
    private_key = file(var.private_key)
    timeout     = "4m"
  }

  user_data = <<-EOF
    echo "">/dev/null
    
      EOF

  # remote-exec - 
  # Execute the "mysql.sh" script copied using "file" provisoner
  provisioner "remote-exec" {
    inline = [
      "chmod +x ${var.ec2_destination_script_path}${var.ec2_destination_script_name}",
      "${var.ec2_destination_script_path}${var.ec2_destination_script_name} ${var.db_version}"
    ]
  }

  tags = {
    Name = "${var.env_prefix}_${var.ec2_name}_${count.index + 1}"
  }
}
