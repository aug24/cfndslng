# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def s3_gpg

    Parameter('KeyBucket') do
      Description 'The name of the bucket in which the gpg keys are kept'
      Default 'launch'
      Type 'String'
    end

    Resource('KeyPolicy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', 'KeyPolicy')
      Property('PolicyDocument', {
        "Id"        => "KeyPolicy",
        "Statement" => [
          {
            "Action" => [
              "s3:GetObject",
              "s3:ListBucket",
              "s3:PutObject"
            ],
            "Sid"      => "ReadWriteAccess",
            "Effect"   => "Allow",
            "Resource" => [ FnJoin("", ["arn:aws:s3:::", Ref("KeyBucket"), "/*"]), FnJoin("", ["arn:aws:s3:::", Ref("KeyBucket")]) ]
          }
        ],
        "Version"   => "2008-10-17"
      })
      Property('Roles', [Ref("InstanceRole")])
    }

  end

end
