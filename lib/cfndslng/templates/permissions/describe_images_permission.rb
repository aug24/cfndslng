# frozen_string_literal: true

CfndslNg.add do
  def describe_images_permission(name='')

    Resource(name + 'DescribeImagesPolicy') do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'DescribeImagesPolicy')
      Property('PolicyDocument', {
        "Id"        => "DescribeImagesPolicy",
        "Statement" => [
          {
            "Action" => [
              "ec2:DescribeImages"
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
