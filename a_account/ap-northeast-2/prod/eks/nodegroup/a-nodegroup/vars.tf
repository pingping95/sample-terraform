# Launch Template
variable "launch_template_image_id" {}
variable "launch_template_instance_type" {}
variable "launch_template_key_name" {}

variable "block_device_mappings" {
  type        = list(any)
  # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template#ebs
  default = [{
    device_name           = "/dev/xvda"
    volume_size           = 100
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }]
}

variable "nodegroup_name" {}

variable "nodegroup_desired_size" {}
variable "nodegroup_min_size" {}
variable "nodegroup_max_size" {}

variable "nodegroup_lt_version" {}
variable "nodegroup_role_arn" {}