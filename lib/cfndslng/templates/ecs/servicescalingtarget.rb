# frozen_string_literal: true
  
CfndslNg.add do
  def servicescalingtarget(name='')
    Resource(name + 'ServiceScalingTarget') do
      Type 'AWS::ApplicationAutoScaling::ScalableTarget'
        Property('MaxCapacity', 2)
        Property('MinCapacity', 1)
        Property('ResourceId', FnJoin( '', [ 'service/', Ref('EcsCluster'), '/', FnGetAtt( 'EcsService', 'Name' ) ] ) )
        Property('RoleARN', FnGetAtt('AutoscalingRole', 'Arn'))
        Property('ScalableDimension', 'ecs:service:DesiredCount')
        Property('ServiceNamespace', 'ecs')
    end
  end
end
