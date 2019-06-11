# frozen_string_literal: true
  
CfndslNg.add do
  def ecsservicerole(name='')
    Resource(name + 'EcsServiceRole') do
      Type 'AWS::IAM::Role'
        Property('AssumeRolePolicyDocument', {
          "Statement": [
            {
              "Effect": "Allow",
              "Principal": {
                "Service": [
                  "ecs.amazonaws.com"
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
            "PolicyName": "ecs-service",
            "PolicyDocument": {
              "Statement": [
                {
                  "Effect": "Allow",
                  "Action": [
                    "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                    "elasticloadbalancing:DeregisterTargets",
                    "elasticloadbalancing:Describe*",
                    "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                    "elasticloadbalancing:RegisterTargets",
                    "ec2:Describe*",
                    "ec2:AuthorizeSecurityGroupIngress"
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
