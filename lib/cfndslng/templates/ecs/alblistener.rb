# frozen_string_literal: true
  
CfndslNg.add do
  def alblistener(name='')
    Resource(name + 'AlbListener') do
      Type 'AWS::ElasticLoadBalancingV2::Listener'
        Property('DefaultActions', [
          {
            "Type": "forward",
            "TargetGroupArn": Ref('EcsTaskGroup')
          }
        ])
        Property('LoadBalancerArn', Ref('EcsAlb') )
        Property('Port', Ref('HostPort') )
        Property('Protocol', 'HTTP')
    end
  end
end
