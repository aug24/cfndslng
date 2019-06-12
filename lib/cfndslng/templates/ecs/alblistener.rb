# frozen_string_literal: true
  
CfndslNg.add do
  def alblistener(name='')
    Resource(name + 'AlbListener') do
      Type 'AWS::ElasticLoadBalancingV2::Listener'
        Property('DefaultActions', [
          {
            "Type": "forward",
            "TargetGroupArn": Ref('Target')
          }
        ])
        Property('LoadBalancerArn', Ref('Alb') )
        Property('Port', Ref('PublicPort') )
        Property('Protocol', 'HTTP')
    end
  end
end
