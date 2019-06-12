# frozen_string_literal: true
  
CfndslNg.add do
  def ecsalblistenerrule(name='')
    Resource(name + 'ECSAlbListenerRule') do
      Type 'AWS::ElasticLoadBalancingV2::ListenerRule'
        Property('Actions', [
          {
            "Type": "forward",
            "TargetGroupArn": Ref('Target')
          }
        ])
        Property('Conditions', [
          {
            "Field": "path-pattern",
            "Values": [ "/" ]
          }
        ])
        Property('ListenerArn', Ref('AlbListener'))
        Property('Priority', 1)
    end
  end
end
