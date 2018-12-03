# frozen_string_literal, true

CfndslNg.add do
  def api(name='')
    Resource(name + 'API') do
      Type('AWS::ApiGateway::RestApi')
      Property('Name', name + 'API')
      Property('Description', 'API')
      Property('FailOnWarnings', true)
    end

    Resource(name + 'APIStage') do
      DependsOn name + 'APIGatewayAccount'
      Type 'AWS::ApiGateway::Stage'
      Property('DeploymentId', Ref(name + 'APIDeployment'))
      Property('MethodSettings', [{
        'DataTraceEnabled' => true,
        'HttpMethod' => '*',
        'LoggingLevel' => 'INFO',
        'ResourcePath' => '/*'
      }])
      Property('RestApiId', Ref(name + 'API'))
      Property('StageName', 'LATEST')
    end
  
    Resource(name + 'APIGatewayAccount') do
      Type 'AWS::ApiGateway::Account'
      Property('CloudWatchRoleArn', FnGetAtt(name + 'APIGatewayCloudWatchLogsRole', 'Arn') )
    end
    
    
    Resource(name + 'APIDeployment') do
      Type 'AWS::ApiGateway::Deployment'
      #DependsOn name + 'Request' + test
      Property('RestApiId', Ref(name + 'API'))
      Property('StageName', 'DummyStage')
    end
    
    Resource(name + 'LambdaPermission') do
      Type('AWS::Lambda::Permission')
      Property('Action', 'lambda:invokeFunction')
      Property('FunctionName', FnGetAtt(name + 'LambdaFunction', 'Arn'))
      Property('Principal', 'apigateway.amazonaws.com')
      Property('SourceArn', FnJoin("", 
          ['arn:aws:execute-api:', Ref('AWS::Region'), ':', Ref('AWS::AccountId'), ':', Ref(name + 'API'), '/*']
      ))
    end

  end
end

