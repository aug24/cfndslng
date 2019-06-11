# frozen_string_literal: true
  
CfndslNg.add do
  def ecssecuritygroupsshinbound(name='')
    Resource(name + 'EcsSecurityGroupSSHinbound') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('EcsSecurityGroup'))
        Property('IpProtocol', 'tcp')
        Property('FromPort', '22')
        Property('ToPort', '22')
        Property('CidrIp', '0.0.0.0/0')
    end
  end
end
