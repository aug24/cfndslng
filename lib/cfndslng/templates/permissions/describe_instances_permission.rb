# frozen_string_literal: true

CfndslNg.add do
  def describe_instances_permission(name='')

    Resource(name + 'DescribeInstancesPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeInstancesPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeInstancesPolicy",
        "Statement" => [
          {
            "Action" => [
              "ec2:DescribeInstances"
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
