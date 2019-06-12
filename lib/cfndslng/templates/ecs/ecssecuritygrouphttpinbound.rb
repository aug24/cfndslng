# frozen_string_literal: true
  
CfndslNg.add do
  def ecssecuritygrouphttpinbound(name='')
    Resource(name + 'EcsSecurityGroupHTTPinbound') do
      Type 'AWS::EC2::SecurityGroupIngress'
        Property('GroupId', Ref('SGELBApp') )
        Property('IpProtocol', 'tcp')
        Property('FromPort',  Ref('PublicPort') )
        Property('ToPort',  Ref('PublicPort') )
        Property('CidrIp', '0.0.0.0/0')
    end
  end
end
