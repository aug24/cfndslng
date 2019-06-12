# frozen_string_literal: true

CfndslNg.add do
  def autoscaling_group(name='')
#    auto_scale_io
#    auto_scale_cpu

    Parameter(name + "PrivateSubnets") {
      Description "Subnet IDs in which the instances should be created"
      Type "List<AWS::EC2::Subnet::Id>"
    }

    Parameter(name + "MinSize") {
      Description "Min Size of Scaling Group"
      Type "String"
      AllowedPattern "[1-9][0-9]*"
    }

    Parameter(name + "MaxSize") {
      Description "Max Size of Scaling Group"
      Type "String"
      AllowedPattern "[1-9][0-9]*"
    }

    Parameter(name + "Version") {
      Description "Application Version"
      Type "String"
      AllowedPattern "[0-9\.]+"
    }
    
    Parameter(name + "Application") {
      Description "Application Name"
      Type "String"
    }
    
    Resource(name  + 'ASG') do
      Type "AWS::AutoScaling::AutoScalingGroup"
      Property("LaunchConfigurationName", Ref(name + "LaunchConfig"))
      Property("LoadBalancerNames", [ Ref("LoadBalancer") ] )
      Property("MinSize",  Ref(name + "MinSize"))
      Property("MaxSize",  Ref(name + "MaxSize"))
      Property("TerminationPolicies", [ "OldestInstance" ])
      Property("HealthCheckGracePeriod", 900)
      Property("VPCZoneIdentifier", Ref(name + "PrivateSubnets") )
      Property("MetricsCollection", [ { "Granularity" => "1Minute" } ] )
      Property("Tags", 
        [
          { 
            "Key"   => 'Version', 
            "Value" => Ref(name + "Version"), 
            "PropagateAtLaunch" => TRUE 
          },
          { 
            "Key"   => 'Application', 
            "Value" => Ref(name + "Application"), 
            "PropagateAtLaunch" => TRUE 
          },
        ] 
      )
    end
  end
end


