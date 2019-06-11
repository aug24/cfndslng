# frozen_string_literal: true

CfndslNg.add do
  def get_ssm_parameters_policy(name='')

    Resource(name + 'ReadSSMPolicy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', name + 'SSMPolicy')
      Property('PolicyDocument', {
        "Id"        => "Policy",
        "Statement" => [
          {
            "Action" => [
              "ssm:GetParameters"
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
