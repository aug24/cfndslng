#!/usr/bin/env ruby
require_relative '../lib/cfndslng.rb'

CloudFormation {
  http_elb
  elb_ingress_from_anywhere_on_public_port
  host_ingress_from_elb_on_private_port
  ssm_policy
  signal_resource_policy
  s3_policy
  update_stack_policy
  update_lambda_policy
  describe_instances_permission
  describe_asgs_permission
  describe_vpcs_permission
  describe_images_permission
  describe_subnets_permission
  describe_keypairs_permission
  describe_elbs_permission
  deploy_ecs_permission
  get_ssm_parameters_policy
  autoscaling_group
  autoscaling_group_policy_for_replacing_update
  launch_config("", 8, templates=["launch_configs/basic", "launch_configs/gitlab", "launch_configs/signal"])
    
  Resource("SGELBApp22" ) {
    Type "AWS::EC2::SecurityGroup"
    Property("GroupDescription" , "ELB inbound permissions")
    Property("VpcId" , Ref("VpcId") )
    Property("SecurityGroupIngress", [
        {
          "IpProtocol" => "TCP",
          "FromPort" => 22,
          "ToPort" => 22,
          "CidrIp" => "0.0.0.0/0",
        } 
    ])
  }

  Resource("SGHostApp22") do
    Type "AWS::EC2::SecurityGroup"
    Property("GroupDescription" , "Host inbound permissions")
    Property("VpcId" , Ref("VpcId") )
    Property("SecurityGroupIngress", [
      {
        "IpProtocol" => "TCP",
        "FromPort" => 22,
        "ToPort" => 22,
        "SourceSecurityGroupId" =>  FnGetAtt("SGELBApp", "GroupId")
      }
    ])
  end

  Output('DNS',FnGetAtt("ELB", "DNSName"))

}
