# frozen_string_literal: true
  
CfndslNg.add do
  def container_policy(name='')
    Resource(name + 'ContainerPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', name + 'ContainerPolicy')
      Property('PolicyDocument', {
        "Id"        => "DeployECSPolicy",
        "Statement" => [
          {
            "Effect": "Allow",
            "Action" => [
              "ecs:CreateCluster",
              "ecs:DeregisterContainerInstance",
              "ecs:DiscoverPollEndpoint",
              "ecs:Poll",
              "ecs:RegisterContainerInstance",
              "ecs:StartTelemetrySession",
              "ecs:Submit*",
              "logs:CreateLogStream",
              "logs:PutLogEvents"
            ],
            "Resource": "*"
          }
        ]
      })
      Property('Roles', [Ref(name + "InstanceRole")])
    end
  end
end
