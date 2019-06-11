# frozen_string_literal: true
  
CfndslNg.add do
  def ecsautoscalinggroup(name='')
    Resource(name + 'EcsAutoscalingGroup') do
      Type 'AWS::AutoScaling::AutoScalingGroup'
        Property('VPCZoneIdentifier', Ref('SubnetId') )
        Property('LaunchConfigurationName', Ref('ContainerInstances') )
        Property('MinSize', '1')
        Property('MaxSize', Ref('MaxSize') )
        Property('DesiredCapacity', Ref('DesiredCapacity') )
        Property('CreationPolicy', { "ResourceSignal": { "Timeout": "PT15M" } })
        Property('UpdatePolicy', { "AutoScalingReplacingUpdate": { "WillReplace": "true" } } )
    end
  end
end
