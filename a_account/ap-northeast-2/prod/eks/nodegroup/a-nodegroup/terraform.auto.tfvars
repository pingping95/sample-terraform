// Shared Variables
tags = {}
env = "prod"

// Launch Template
// https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html
// https://us-west-1.console.aws.amazon.com/systems-manager/parameters/aws/service/eks/optimized-ami/1.21/amazon-linux-2/recommended/image_id/description?region=ap-northeast-2#
launch_template_image_id      = "ami-0e155c8c5a16e76f9"
launch_template_instance_type = "m6g.2xlarge"
launch_template_key_name      = "my-ec2-key"

// Node Group
nodegroup_desired_size = 2
nodegroup_min_size     = 2
nodegroup_max_size     = 30

nodegroup_name       = "worker"
nodegroup_lt_version = "$Latest"