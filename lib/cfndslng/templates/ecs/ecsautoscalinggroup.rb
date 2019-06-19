# frozen_string_literal: true
  
CfndslNg.add do
  def ecsautoscalinggroup(name='')
    Parameter(name + "Version") {
      Description "Application Version"
      Type "String"
      AllowedPattern "[0-9\.]+"
    }

    Resource(name + 'EcsAutoscalingGroup') do
      Type 'AWS::AutoScaling::AutoScalingGroup'
        Property('VPCZoneIdentifier', Ref('PrivateSubnets') )
        Property('LaunchConfigurationName', Ref('LaunchConfig') )
        Property('MinSize', '1')
        Property('MaxSize', Ref('MaxSize') )
        Property('DesiredCapacity', Ref('DesiredCapacity') )
        Property('CreationPolicy', { "ResourceSignal": { "Timeout": "PT15M" } })
        Property('UpdatePolicy', { "AutoScalingReplacingUpdate": { "WillReplace": "true" } } )
    end
  end
end
