# frozen_string_literal: true

CfndslNg.add do
  def describe_elbs_permission(name='')

    Resource(name + 'DescribeELBsPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeELBsPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeELBsPolicy",
        "Statement" => [
          {
            "Action" => [
              "elasticloadbalancing:DescribeLoadBalancers"
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
