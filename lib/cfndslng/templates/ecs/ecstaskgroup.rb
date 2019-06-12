# frozen_string_literal: true
  
CfndslNg.add do
  def ecstaskgroup(name='')
    Parameter(name + 'PublicPort') do
      Type 'Number'
      Default 80
      Description 'Port on which the host listens, forwarded to ContainerPort'
    end

    Parameter(name + 'VpcId') do
      Type 'AWS::EC2::VPC::Id'
      Description 'Select a VPC that allows instances to access the Internet.'
    end

    Parameter(name + 'PrivateSubnets') do
      Type 'List<AWS::EC2::Subnet::Id>'
      Description 'Select at two subnets in your selected VPC.'
    end

    Parameter(name + 'MaxSize') do
      Type 'Number'
      Default '1'
      Description 'Maximum number of instances that can be launched in your ECS cluster.'
    end

    Parameter(name + 'DesiredCapacity') do
      Type 'Number'
      Default '1'
      Description 'Preferred number of instances'
    end

    Resource(name + 'Target') do
      Type 'AWS::ElasticLoadBalancingV2::TargetGroup'
        Property('HealthCheckIntervalSeconds', 10)
        Property('HealthCheckPath', '/')
        Property('HealthCheckProtocol', 'HTTP')
        Property('HealthCheckTimeoutSeconds', 5)
        Property('HealthyThresholdCount', 2)
        Property('Name', 'EcsTaskGroup')
        Property('Port',  Ref('PublicPort'))
        Property('Protocol', 'HTTP')
        Property('UnhealthyThresholdCount', 2)
        Property('VpcId', Ref('VpcId'))
    end
  end
end
