# frozen_string_literal: true
  
CfndslNg.add do
  def servicescalingpolicy(name='')
    Resource(name + 'ServiceScalingPolicy') do
      Type 'AWS::ApplicationAutoScaling::ScalingPolicy'
        Property('PolicyName', 'AStepPolicy')
        Property('PolicyType', 'StepScaling')
        Property('ScalingTargetId', Ref('ServiceScalingTarget'))
        Property('StepScalingPolicyConfiguration', {
          "AdjustmentType": "PercentChangeInCapacity",
          "Cooldown": 60,
          "MetricAggregationType": "Average",
          "StepAdjustments": [
            {
              "MetricIntervalLowerBound": 0,
              "ScalingAdjustment": 200
            }
          ]
        })
    end
  end
end
