require 'cfndslng/templates/s3_gpg.rb'
require 'cfndslng/templates/buckets/private_bucket.rb'
require 'cfndslng/templates/buckets/public_bucket.rb'
require 'cfndslng/templates/load_balancing/https_alb.rb'
require 'cfndslng/templates/load_balancing/http_alb.rb'
require 'cfndslng/templates/load_balancing/host_ingress_from_elb_on_private_port.rb'
require 'cfndslng/templates/load_balancing/https_elb.rb'
require 'cfndslng/templates/load_balancing/http_elb.rb'
require 'cfndslng/templates/load_balancing/elb_ingress_from_anywhere_on_public_port.rb'
require 'cfndslng/templates/puppet.rb'
require 'cfndslng/templates/api_gateway/api.rb'
require 'cfndslng/templates/api_gateway/request.rb'
require 'cfndslng/templates/ecs/ecsservicerole.rb'
require 'cfndslng/templates/ecs/ecscluster.rb'
require 'cfndslng/templates/ecs/repository.rb'
require 'cfndslng/templates/ecs/ecs_ami.rb'
require 'cfndslng/templates/ecs/ecssecuritygroup.rb'
require 'cfndslng/templates/ecs/ecsalblistenerrule.rb'
require 'cfndslng/templates/ecs/containerinstances.rb'
require 'cfndslng/templates/ecs/servicescalingpolicy.rb'
require 'cfndslng/templates/ecs/ecsservice.rb'
require 'cfndslng/templates/ecs/autoscalingrole.rb'
require 'cfndslng/templates/ecs/ecsautoscalinggroup.rb'
require 'cfndslng/templates/ecs/alb500salarmscaleup.rb'
require 'cfndslng/templates/ecs/alblistener.rb'
require 'cfndslng/templates/ecs/servicescalingtarget.rb'
require 'cfndslng/templates/ecs/host_ingress_from_elb_on_all_high_ports.rb'
require 'cfndslng/templates/ecs/ecstaskgroup.rb'
require 'cfndslng/templates/ecs/taskdefinition.rb'
require 'cfndslng/templates/permissions/describe_keypairs_permission.rb'
require 'cfndslng/templates/permissions/signal_resource_policy.rb'
require 'cfndslng/templates/permissions/describe_asgs_permission.rb'
require 'cfndslng/templates/permissions/describe_subnets_permission.rb'
require 'cfndslng/templates/permissions/deploy_ecs_permission.rb'
require 'cfndslng/templates/permissions/describe_vpcs_permission.rb'
require 'cfndslng/templates/permissions/describe_images_permission.rb'
require 'cfndslng/templates/permissions/describe_stack_permission.rb'
require 'cfndslng/templates/permissions/s3_policy.rb'
require 'cfndslng/templates/permissions/update_lambda_policy.rb'
require 'cfndslng/templates/permissions/container_policy.rb'
require 'cfndslng/templates/permissions/describe_instances_permission.rb'
require 'cfndslng/templates/permissions/update_stack_policy.rb'
require 'cfndslng/templates/permissions/get_ssm_parameters_policy.rb'
require 'cfndslng/templates/permissions/describe_elbs_permission.rb'
require 'cfndslng/templates/permissions/ssm_policy.rb'
require 'cfndslng/templates/tags/stacktag.rb'
require 'cfndslng/templates/launch_config.rb'
require 'cfndslng/templates/lambda/lambda_function.rb'
require 'cfndslng/templates/lambda/lambda_target.rb'
require 'cfndslng/templates/cloud_init.rb'
require 'cfndslng/templates/vpc/vpn_gateway.rb'
require 'cfndslng/templates/vpc/private_subnet.rb'
require 'cfndslng/templates/vpc/on_premises_connection.rb'
require 'cfndslng/templates/vpc/outbound_private_route.rb'
require 'cfndslng/templates/vpc/internet_gateway.rb'
require 'cfndslng/templates/vpc/vpc.rb'
require 'cfndslng/templates/autoscaling/autoscaling_group.rb'
require 'cfndslng/templates/autoscaling/autoscaling_group_policy_for_replacing_update.rb'
require 'cfndslng/templates/common_statements.rb'
