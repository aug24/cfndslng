# frozen_string_literal: true

CfndslNg.add do
  def http_alb(name = '')

    Parameter("PublicPort") {
      Description "The port on which the proxy will listen and healthcheck"
      Type "String"
    }

    Parameter(name + "PrivateSubnets") {
      Description "Subnet IDs in which the instances should be created"
      Type "List<AWS::EC2::Subnet::Id>"
    }

    Resource(name + 'Alb') do
      Type "AWS::ElasticLoadBalancingV2::LoadBalancer"
        Property('Name', 'Alb')
        Property('Scheme', 'internet-facing')
        Property('LoadBalancerAttributes', [
          { 
            "Key": "idle_timeout.timeout_seconds",
            "Value": "30"
          }
        ])
        Property('Subnets', Ref('PrivateSubnets'))
        Property('SecurityGroups', [ Ref('SGELBApp') ])
    end

    Resource(name + 'LoadBalancerListener') do
      Type 'AWS::ElasticLoadBalancingV2::Listener'
      Property( 'DefaultActions', [{
        'Type': 'forward',
        'TargetGroupArn': Ref( name + 'Target' ) }]
      )
      Property( 'LoadBalancerArn', Ref( name + 'Alb' ))
      Property( 'Port', Ref('PublicPort') )
      Property( 'Protocol', 'HTTP')
    end

    Output('Alb') do
      Description 'ALB DNS'
      Value(FnGetAtt( "Alb", "DNSName" ))
    end

  end
end
