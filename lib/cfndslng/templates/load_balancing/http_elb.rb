# frozen_string_literal: true

CfndslNg.add do
  def http_elb

    Parameter("PublicPort") {
      Description "The port on which the proxy will listen and healthcheck"
      Type "String"
    }

    Parameter("PrivatePort") {
      Description "The port to which the proxy will send requests"
      Type "String"
    }

    Parameter("PingPath") do
      Description "The path to ping for the elb healthcheck"
      Type "String"
    end

    Resource("ELB") do
      Type "AWS::ElasticLoadBalancing::LoadBalancer"
      Property("CrossZone", true)
      Property("ConnectionDrainingPolicy", { "Enabled" => true, "Timeout" => "30" })
      Property("HealthCheck" , {
         "HealthyThreshold": 2,
         "Interval": "30",
         "Target": Ref("PingPath"),
         "Timeout": 10,
         "UnhealthyThreshold": 2
      })
      Property("Listeners" , [
        {
          "LoadBalancerPort" => Ref("PublicPort"),
          "InstancePort" => Ref("PrivatePort"),
          "Protocol" => "HTTP"
        }
      ])
      Property('Subnets', Ref('PrivateSubnets'))
      Property("SecurityGroups", [ FnGetAtt("SGELBApp", "GroupId") ])
    end

  end
end
