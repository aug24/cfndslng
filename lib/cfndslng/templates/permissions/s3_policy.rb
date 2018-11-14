# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def s3_policy(bucketname='', resourcename='')

    Parameter(bucketname + 'BucketName') {
      Description "The name of the bucket"
      Type "String"
    }

    Resource(bucketname + resourcename + 'S3Policy') {
      Type 'AWS::IAM::Policy'
      Property('PolicyName', bucketname + resourcename + 'S3Policy')
      Property('PolicyDocument', {
        "Id"        => "Policy",
        "Statement" => [
          {
            "Action" => [
              "s3:GetObject",
              "s3:ListBucket",
              "s3:PutObject"
            ],
            "Sid"      => "ReadWriteAccess",
            "Effect"   => "Allow",
            "Resource" => [ FnJoin("", ["arn:aws:s3:::", Ref(bucketname + "BucketName"), "/*"]), FnJoin("", ["arn:aws:s3:::", Ref(bucketname + "BucketName")]) ]
          }
        ],
        "Version"   => "2008-10-17"
      })
      Property('Roles', [Ref(resourcename + "InstanceRole")])
    }

  end

end
