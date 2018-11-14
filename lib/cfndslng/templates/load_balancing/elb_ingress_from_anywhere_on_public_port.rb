# frozen_string_literal: true

CfndslNg.add do
  def elb_ingress_from_anywhere_on_public_port

    Parameter("VpcId") {
      Type "String"
    }

    Resource("SGELBApp" ) {
      Type "AWS::EC2::SecurityGroup"
      Property("GroupDescription" , "ELB inbound permissions")
      Property("VpcId" , Ref("VpcId") )
      Property("SecurityGroupIngress", [
          {
            "IpProtocol" => "TCP",
            "FromPort" => Ref("PublicPort"),
            "ToPort" => Ref("PublicPort"),
            "CidrIp" => "0.0.0.0/0",
          } 
      ])
    }

  end
end


