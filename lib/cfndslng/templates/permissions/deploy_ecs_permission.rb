# frozen_string_literal: true

CfndslNg.add do
  def deploy_ecs_permission(name='')

    Resource(name + 'DeployECSPermission') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DeployECSPolicy')
      Property('PolicyDocument', {
        "Id"        => "DeployECSPolicy",
        "Statement" => [
          {
            "Action" => [
              "ecs:RegisterTaskDefinition",
              "ecs:DeregisterTaskDefinition",
              "ecs:DescribeServices",
              "ecs:UpdateService",
              "ecs:DeleteService",
              "ecs:CreateService",
              "application-autoscaling:RegisterScalableTarget",
              "application-autoscaling:DeregisterScalableTarget",
              "application-autoscaling:Describe*",
              "application-autoscaling:PutScalingPolicy",
              "application-autoscaling:DeleteScalingPolicy",
              "cloudwatch:PutMetricAlarm",
              "iam:GetRole"
            ],
            "Sid"      => "ReadWriteAccess",
            "Effect"   => "Allow",
            "Resource" => "*",
          }
        ],
        "Version"   => "2008-10-17"
      })
      Property('Roles', [Ref(name + "InstanceRole")])
    end

  end

end
