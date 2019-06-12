# frozen_string_literal: true

CfndslNg.add do


  def lambda_target(name='')

    Parameter(name + 'VPC') {
      Description 'The name of the VPC in which the lambda will run'
      Type 'AWS::EC2::VPC::Id'
    }
    
    Resource(name + 'Target') do
    Type 'AWS::ElasticLoadBalancingV2::TargetGroup'
      Property( 'HealthCheckIntervalSeconds', 5)
      Property( 'HealthCheckPath', '/healthcheck')
      Property( 'Name', name + 'TargetGroup')
      Property( 'TargetType', 'lambda')
      Property( 'VpcId', Ref(name + 'VPC'))
#      Property( 'Port', 80)
#      Property( 'Protocol', 'HTTP')
    #  Property(
    #  )
  
    #'HealthCheckPort'
    #'HealthCheckProtocol'
    #'HealthCheckTimeoutSeconds'
    #'HealthyThresholdCount'
    #'Matcher'
    #'TargetGroupAttributes'
    #'Targets'
    #'UnhealthyThresholdCount'

    #Property("Tags", 
    #          [
    #            { 
    #              "Key"   => 'Version', 
    #              "Value" => Ref(name + "SourceVersion") 
    #            },
    #            { 
    #              "Key"   => 'Application', 
    #              "Value" => Ref(name + "Application") 
    #            },
    #          ] 
    #        )
    end
  end

end


