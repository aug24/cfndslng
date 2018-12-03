# frozen_string_literal: true

CfndslNg.add do
  def lambda_function(name='')

    Parameter(name + 'SourceBucketName') {
      Description 'The name of the bucket in which the source is placed'
      Type 'String'
    }
    
    Parameter(name + 'SourceVersion') {
      Description 'The key to the source file in the bucket'
      Type 'String'
    }
    
    Parameter(name + 'Handler') {
      Description 'The handler for the function'
      Type 'String'
    }
    
    Parameter(name + "Application") {
      Description "Application Name"
      Type "String"
    }
        
        
    Resource(name + 'LambdaFunction') do
      Type 'AWS::Lambda::Function'
      Property('Code', {
        "S3Bucket"  => Ref(name + 'SourceBucketName'),
        "S3Key" => 
        FnJoin("", [Ref(name + 'Application'), '-', Ref(name + 'SourceVersion'), '.jar' ])
         
      })
#      Property('Environment', Environment)
      Property('FunctionName', name + 'LambdaFunction')
      Property('Handler', Ref(name + 'Handler'))
#      Property('MemorySize', Integer)
      Property('Role', FnGetAtt(name + 'LambdaFunctionCloudWatchLogsRole', 'Arn'))
      Property('Runtime', 'java8')
#      Property('Timeout', Integer)
#      Property('VpcConfig', VPCConfig)
      Property("Tags", 
              [
                { 
                  "Key"   => 'Version', 
                  "Value" => Ref(name + "SourceVersion") 
                },
                { 
                  "Key"   => 'Application', 
                  "Value" => Ref(name + "Application") 
                },
              ] 
            )
    end

    Resource(name + 'APIGatewayCloudWatchLogsRole') do
      Type 'AWS::IAM::Role'
      Property('AssumeRolePolicyDocument', {
        'Version' => '2012-10-17',
        'Statement' => [{
          'Effect' => 'Allow',
          'Principal' => { 'Service'  => ['apigateway.amazonaws.com'] },
          'Action' => ['sts:AssumeRole']
        }]
      })
      Property('Policies', [{
        'PolicyName'  => 'ApiGatewayLogsPolicy',
        'PolicyDocument' => {
          'Version' => '2012-10-17',
          'Statement' => [{
            'Effect'  => 'Allow',
            'Action' => [
              'logs:CreateLogGroup',
              'logs:CreateLogStream',
              'logs:DescribeLogGroups',
              'logs:DescribeLogStreams',
              'logs:PutLogEvents',
              'logs:GetLogEvents',
              'logs:FilterLogEvents'
            ],
            'Resource' => '*'
          }]
        }
      }])
    end

    Resource(name + 'LambdaFunctionCloudWatchLogsRole') do
      Type 'AWS::IAM::Role'
      Property('AssumeRolePolicyDocument', {
        'Version' => '2012-10-17',
        'Statement' => [{
          'Effect' => 'Allow',
          'Principal' => { 'Service'  => ['lambda.amazonaws.com'] },
          'Action' => ['sts:AssumeRole']
        }]
      })
      Property('Policies', [{
        'PolicyName'  => 'ApiGatewayLogsPolicy',
        'PolicyDocument' => {
          'Version' => '2012-10-17',
          'Statement' => [{
            'Effect'  => 'Allow',
            'Action' => [
              'logs:CreateLogGroup',
              'logs:CreateLogStream',
              'logs:DescribeLogGroups',
              'logs:DescribeLogStreams',
              'logs:PutLogEvents',
              'logs:GetLogEvents',
              'logs:FilterLogEvents'
            ],
            'Resource' => '*'
          }]
        }
      }])
    end
  end

end


