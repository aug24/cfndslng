# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def signal_resource_policy(name='')

    Resource(name + 'SignalResourcePolicy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', name + 'SignalResourcePolicy')
      Property('PolicyDocument', {
        "Id"        => "Policy",
        "Statement" => [
          {
            "Action" => [
              "cloudformation:SignalResource"
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
