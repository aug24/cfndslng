# frozen_string_literal: true
  
CfndslNg.add do
  def autoscalingrole(name='')
    Resource(name + 'AutoscalingRole') do
      Type 'AWS::IAM::Role'
        Property('AssumeRolePolicyDocument', {
          "Statement": [
            {
              "Effect": 'Allow',
              "Principal": {
                "Service": [
                  "application-autoscaling.amazonaws.com"
                ]
              },
              "Action": [
                "sts:AssumeRole"
              ]
            }
          ]
        })
        Property('Path', '/')
        Property('Policies', [
          {
            "PolicyName": 'service-autoscaling',
            "PolicyDocument": {
              "Statement": [
                {
                  "Effect": 'Allow',
                  "Action": [
                    "application-autoscaling:*",
                    "cloudwatch:DescribeAlarms",
                    "cloudwatch:PutMetricAlarm",
                    "ecs:DescribeServices",
                    "ecs:UpdateService"
                  ],
                  "Resource": "*"
                }
              ]
            }
          }
        ])
    end
  end
end
