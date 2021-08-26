terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"
  name           = "my-ec2-cluster"
  count          = var.ec2_instance_count
  ami            = var.ami
  instance_type  = var.instance_type
  
	tags = {
		Name= "task${count.index}"
	}
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = "${var.ec2_instance_count * var.ec2_ebs_volume_count}"
  availability_zone = "ap-south-1a"
  size              = "${var.ec2_ebs_volume_size}"
}

resource "aws_volume_attachment" "volume_attachement" {
  count       = "${var.ec2_instance_count * var.ec2_ebs_volume_count}"
  volume_id   = "${aws_ebs_volume.ebs_volume.*.id[count.index]}"
  device_name = "${element(var.ec2_device_names, count.index)}"
  instance_id = "${element(aws_instance.web.*.id, count.index)}"
}
