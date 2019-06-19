#!/usr/bin/env ruby
require_relative '../lib/cfndslng.rb'

CloudFormation {
#   alb500salarmscaleup
#   alblistener
   autoscalingrole
   launch_config("", '', templates=["launch_configs/basic", "launch_configs/container", "launch_configs/signal"])
#   docker_launch_config
   http_alb
   ecsalblistenerrule
   autoscaling_group
   ecscluster
   ecssecuritygroup
   ecsservice
   ecsservicerole
   ecstaskgroup
#   servicescalingpolicy
#   servicescalingtarget
   taskdefinition
   host_ingress_from_elb_on_all_high_ports
   ecs_ami

   container_policy

   describe_instances_permission
   describe_asgs_permission
   describe_vpcs_permission
   describe_images_permission
   describe_subnets_permission
   describe_keypairs_permission
   describe_elbs_permission
   describe_cloudformation_permission

   autoscaling_group_policy_for_replacing_update

}

