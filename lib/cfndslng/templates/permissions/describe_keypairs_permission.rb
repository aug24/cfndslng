# frozen_string_literal: true

CfndslNg.add do
  def describe_keypairs_permission(name='')

    Resource(name + 'DescribeKeypairsPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeKeypairsPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeKeypairsPolicy",
        "Statement" => [
          {
            "Action" => [
              "ec2:DescribeKeyPairs"
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
