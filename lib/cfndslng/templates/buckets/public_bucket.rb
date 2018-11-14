# frozen_string_literal: true

CfndslNg.add do
  def public_bucket(name='')

    Parameter(name + 'BucketName') {
      Description "The name of the bucket"
      Type "String"
    }

    Resource(name + "Bucket") do
      Type 'AWS::S3::Bucket'
      Property('BucketName', Ref(name + 'BucketName'))
    end

  end

end
