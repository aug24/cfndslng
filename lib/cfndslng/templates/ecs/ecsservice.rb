# frozen_string_literal: true
  
CfndslNg.add do

  def ecsservice(name='')
    Parameter(name + 'ApplicationName') {
      Type 'String'
      Description 'Application Name'
    }

    Parameter(name + 'ContainerPort') {
      Type 'Number'
      Default 80
      Description 'Port on which the container listens'
    }

    Resource(name + 'EcsService') do
      Type 'AWS::Ecs::Service'
        Property('Cluster', Ref('EcsCluster'))
        Property('DesiredCount', '1')
        Property('LoadBalancers', [
          {
            "ContainerName":  Ref('ApplicationName'),
            "ContainerPort":  Ref('ContainerPort'),
            "TargetGroupArn": Ref('Target')
          }
        ])
        Property('Role', Ref('EcsServiceRole'))
        Property('TaskDefinition', Ref('TaskDefinition'))
    end
  end
end
