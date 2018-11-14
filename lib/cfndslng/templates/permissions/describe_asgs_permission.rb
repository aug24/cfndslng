# frozen_string_literal: true

CfndslNg.add do
  def describe_asgs_permission(name='')

    Resource(name + 'DescribeASGsPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeASGsPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeASGsPolicy",
        "Statement" => [
          {
            "Action" => [
              "autoscaling:DescribeAutoScalingGroups"
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
