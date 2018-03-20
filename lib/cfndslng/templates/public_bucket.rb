# frozen_string_literal: true

CfndslNg.add do
  def public_bucket

    Parameter("BucketName") {
      Description "The name of the bucket"
      Type "String"
    }

    Resource("Bucket") do
      Type 'AWS::S3::Bucket'
      Property('BucketName', Ref('BucketName'))
    end

  end

end
