# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def update_stack_policy(name='')

    Resource(name + 'UpdateStackPolicy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', name + 'UpdateStackPolicy')
      Property('PolicyDocument', {
        "Id"        => "Policy",
        "Statement" => [
          {
            "Action" => [
              "iam:PassRole",
              "cloudformation:UpdateStack",
              "autoscaling:CreateLaunchConfiguration",
              "autoscaling:DeleteLaunchConfiguration",
              "autoscaling:CreateAutoScalingGroup",
              "autoscaling:DeleteAutoScalingGroup",
              "autoscaling:EnableMetricsCollection",
              "autoscaling:UpdateAutoScalingGroup",
              "autoscaling:DescribeLaunchConfigurations",
              "autoscaling:DescribeScalingActivities",
              "autoscaling:DescribeAutoScalingInstances"
            ],
            "Effect"   => "Allow",
            "Resource" => "*"
          }
        ],
        "Version"   => "2008-10-17"
      })
      Property('Roles', [Ref(name + "InstanceRole")])
    }

  end

end
