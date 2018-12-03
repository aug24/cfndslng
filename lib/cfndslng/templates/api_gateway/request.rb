# frozen_string_literal: true

CfndslNg.add do
  def request(name='', method, path, params)
    
    Resource(name + 'Resource' + path.gsub("/", "_")) do
      Type 'AWS::ApiGateway::Resource'
      Property('RestApiId', Ref(name + 'API'))
      Property('ParentId', FnGetAtt(name + 'API', 'RootResourceId'))
      Property('PathPart', path)
    end
    
    Resource(name + 'Request' + path.gsub("/", "_")) do
      Type  'AWS::ApiGateway::Method'
      DependsOn name + 'LambdaPermission'
      Property('AuthorizationType', 'NONE')
      Property('HttpMethod', method)             # This is the method which AG accepts from users.  Can be any.
      Property('Integration', {
            'Type' => 'AWS',
            'IntegrationHttpMethod' => 'POST',  # This is the method which AG uses to request from Lambda.  Must be POST.
            'Uri' => FnJoin('', [
                'arn:aws:apigateway:', 
                Ref('AWS::Region'), 
                ':lambda:path/2015-03-31/functions/', 
                FnGetAtt(name + 'LambdaFunction', 'Arn'),
                '/invocations'
            ]),
            'IntegrationResponses' => [{
              'StatusCode' => 200
            }],
            'RequestTemplates' => {
              'application/json' => FnJoin("", [ 
                "{",
                params.map{ |param| "\"" + param + "\": \"$input.params('" + param + "')\"" }
                  .push("\"path\": \"" + path + "\"") 
                  .join(','),
                "}"
                  ])
            }})
      Property('RequestParameters', { 'method.request.querystring.name' => false })
      Property('ResourceId', Ref(name + 'Resource' + path.gsub("/", "_")))
      Property('RestApiId', Ref(name + 'API'))
      Property('MethodResponses', [{ 'StatusCode' => 200 }])
    end
  end
end

