data "aws_availability_zones" "this" {
  state = "available"
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    CLUSTER_NAME = local.cluster_name
  }
}