# frozen_string_literal: true
  
CfndslNg.add do
  def alb500salarmscaleup(name='')
    Resource(name + 'Alb500sAlarmScaleUp') do
      Type 'AWS::CloudWatch::Alarm'
        Property('EvaluationPeriods', '1')
        Property('Statistic', 'Average')
        Property('Threshold', '10')
        Property('AlarmDescription', 'Alarm if our ALB generates too many HTTP 500s.')
        Property('Period', '60')
        Property('AlarmActions', [ Ref('ServiceScalingPolicy') ])
        Property('Namespace', 'AWS/ApplicationELB')
        Property('Dimensions', [
          {
            "Name": "LoadBalancer",
            "Value": FnGetAtt( 'Alb', 'LoadBalancerFullName' )
          }
        ])
        Property('ComparisonOperator', 'GreaterThanThreshold')
        Property('MetricName', 'HTTPCode_ELB_5XX_Count')
    end
  end
end
