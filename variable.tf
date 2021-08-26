variable "ami" {
    default = "ami-00bf4ae5a7909786c"
}
variable "instance_type" {
    default = "t2.micro"  
}
variable "ec2_ebs_volume_size" {
    default = "8"  
}

variable "ec2_device_names" {
  default = [
    "/dev/sdd",
    "/dev/sde",
    "/dev/sdf",
  ]
}

variable "ec2_instance_count" {
  default = 2
}

variable "ec2_ebs_volume_count" {
  default = 2
}
