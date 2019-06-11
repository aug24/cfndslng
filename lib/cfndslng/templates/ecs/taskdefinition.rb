# frozen_string_literal: true
  
CfndslNg.add do
  def taskdefinition(name='')

    Parameter(name + 'ImageLocation') do
      Type 'String'
      Description 'Docker image location'
    end

    Resource(name + 'TaskDefinition') do
      Type 'AWS::ECS::TaskDefinition'
        Property('Family', FnJoin( '', [ Ref('AWS::StackName'), '-ecs-demo-app' ] ))
        Property('ContainerDefinitions', [
          {
            "Name": Ref('ApplicationName'),
            "Cpu": "10",
            "Essential": "true",
            "Image": Ref('ImageLocation'),
            "Memory": "300",
            "LogConfiguration": {
              "LogDriver": "awslogs",
              "Options": {
                "awslogs-group": Ref('CloudwatchLogsGroup'),
                "awslogs-region": Ref('AWS::Region'),
                "awslogs-stream-prefix": "ecs-demo-app"
              }
            },
            "MountPoints": [
              {
                "ContainerPath": "/usr/local/apache2/htdocs",
                "SourceVolume": "my-vol"
              }
            ],
            "PortMappings": [ { "ContainerPort": Ref('ContainerPort') } ]
          }
        ])
        Property('Volumes', [ { "Name": "my-vol" } ])
    end

    Resource(name + 'CloudwatchLogsGroup') do
      Type 'AWS::Logs::LogGroup'
        Property('LogGroupName', FnJoin( '-', [ 'ECSLogGroup', Ref('AWS::StackName') ]))
        Property('RetentionInDays', 14)
    end
  end
end
