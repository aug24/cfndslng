# frozen_string_literal: true
  
CfndslNg.add do
  def ecssecuritygrouphttpinbound(name='')
    Resource(name + 'EcsSecurityGroupHTTPinbound') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('EcsSecurityGroup') )
        Property('IpProtocol', 'tcp')
        Property('FromPort',  Ref('HostPort') )
        Property('ToPort',  Ref('HostPort') )
        Property('CidrIp', '0.0.0.0/0')
    end
  end
end
