# frozen_string_literal: true
  
CfndslNg.add do
  def ecssecuritygroup(name='')
    Resource(name + 'SGLoadBalancerToApp') do
      Type 'AWS::EC2::SecurityGroup'
        Property('GroupDescription', 'ECS Security Group')
        Property('VpcId', Ref('VpcId'))
    end

    Resource(name + 'EcsSecurityGroupALBports') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('SGLoadBalancerToApp') )
        Property('IpProtocol', 'tcp')
        Property('FromPort', '31000')
        Property('ToPort', '61000')
        Property('SourceSecurityGroupId', Ref('SGLoadBalancerToApp') )
    end

    Resource(name + 'EcsSecurityGroupHTTPinbound') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('SGLoadBalancerToApp') )
        Property('IpProtocol', 'tcp')
        Property('FromPort',  Ref('PublicPort') )
        Property('ToPort',  Ref('PublicPort') )
        Property('CidrIp', '0.0.0.0/0')
    end
  end
end
