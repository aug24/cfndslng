# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def ssm_policy(name='')

    Resource(name + 'SSMPolicy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', name + 'SSMPolicy')
      Property('PolicyDocument', {
        "Id"        => "Policy",
        "Statement" => [
          {
            "Action" => [
              "ec2messages:AcknowledgeMessage",
              "ec2messages:DeleteMessage",
              "ec2messages:FailMessage",
              "ec2messages:GetEndpoint",
              "ec2messages:GetMessages",
              "ec2messages:SendReply",
              "ssm:UpdateInstanceInformation",
              "ssm:ListInstanceAssociations",
              "ssm:DescribeInstanceProperties",
              "ssm:DescribeDocumentParameters"
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
