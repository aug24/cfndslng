# frozen_string_literal: true

CfndslNg.add do
  def describe_vpcs_permission(name='')

    Resource(name + 'DescribeVPCsPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeVPCsPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeVPCsPolicy",
        "Statement" => [
          {
            "Action" => [
              "ec2:DescribeVpcs"
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
