# frozen_string_literal: true
  
CfndslNg.add do
  def ecsalb(name='')
    Resource(name + 'EcsAlb') do
      Type 'AWS::ElasticLoadBalancingV2::LoadBalancer'
        Property('Name', 'EcsAlb')
        Property('Scheme', 'internet-facing')
        Property('LoadBalancerAttributes', [
          {
            "Key": "idle_timeout.timeout_seconds",
            "Value": "30"
          }
        ])
        Property('Subnets', Ref('SubnetId'))
        Property('SecurityGroups', [ Ref('EcsSecurityGroup') ])
    end
    Output('EcsAlb') do
      Description 'Your ALB DNS URL'
      Value(FnGetAtt( "EcsAlb", "DNSName" ))
    end
  end
end
