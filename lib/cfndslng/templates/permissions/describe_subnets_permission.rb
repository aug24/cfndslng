# frozen_string_literal: true

CfndslNg.add do
  def describe_subnets_permission(name='')

    Resource(name + 'DescribeSubnetsPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeSubnetsPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeSubnetsPolicy",
        "Statement" => [
          {
            "Action" => [
              "ec2:DescribeSubnets"
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
