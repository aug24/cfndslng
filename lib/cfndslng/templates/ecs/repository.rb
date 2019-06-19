# frozen_string_literal: true
  
CfndslNg.add do
  def repository(name='')
    Parameter(name + 'Name') do
      Type 'String'
      Description 'Name of docker repo to be created'
    end

    Resource(name + 'EcsRepository') do
      Type 'AWS::ECR::Repository'
      #Property('LifecyclePolicy' : LifecyclePolicy,
      Property('RepositoryName', Ref(name + 'Name'))
      Property('RepositoryPolicyText', {
        'Version' => '2012-10-17',
        'Statement' => [
          {
            "Sid" => "AllowPushPull",
            'Effect' => 'Allow',
            'Action' => [
              "ecr:GetDownloadUrlForLayer",
              "ecr:BatchGetImage",
              "ecr:BatchCheckLayerAvailability",
              "ecr:PutImage",
              "ecr:InitiateLayerUpload",
              "ecr:UploadLayerPart",
              "ecr:CompleteLayerUpload"
            ],
            'Principal' => { "AWS" => [ FnJoin('', ['arn:aws:iam::', Ref('AWS::AccountId'), ':root']) ] }
          }
        ]
      })

    end
  end
end
