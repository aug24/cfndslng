# frozen_string_literal: true

CfndslNg.add do
  def host_ingress_from_elb_on_all_high_ports

    Parameter("PrivatePort") {
      Type "String"
    }

    Resource("SGHostApp") do
      Type "AWS::EC2::SecurityGroup"
      Property("GroupDescription" , "Host inbound permissions")
      Property("VpcId" , Ref("VpcId") )
      Property("SecurityGroupIngress", [
        {
          "IpProtocol" => "TCP",
          "FromPort" => 31000,
          "ToPort" => 65535,
          "SourceSecurityGroupId" =>  FnGetAtt("SGLoadBalancerToApp", "GroupId")
        }
      ])
    end

  end
end



