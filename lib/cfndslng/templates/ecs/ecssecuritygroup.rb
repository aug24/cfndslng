# frozen_string_literal: true
  
CfndslNg.add do
  def ecssecuritygroup(name='')
    Resource(name + 'EcsSecurityGroup') do
      Type 'AWS::EC2::SecurityGroup'
        Property('GroupDescription', 'ECS Security Group')
        Property('VpcId', Ref('VpcId'))
    end

    Resource(name + 'EcsSecurityGroupALBports') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('EcsSecurityGroup') )
        Property('IpProtocol', 'tcp')
        Property('FromPort', '31000')
        Property('ToPort', '61000')
        Property('SourceSecurityGroupId', Ref('EcsSecurityGroup') )
    end
  end
end
