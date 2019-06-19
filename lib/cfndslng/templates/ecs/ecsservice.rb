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
      Type 'AWS::ECS::Service'
        DependsOn ['Target', 'LoadBalancer', 'LoadBalancerListener']
        Property('Cluster', Ref(name + 'EcsCluster'))
        Property('DesiredCount', '1')
        Property('LoadBalancers', [
          {
            "ContainerName":  Ref('ApplicationName'),
            "ContainerPort":  Ref('ContainerPort'),
            "TargetGroupArn": Ref('Target')
          }
        ])
        Property('Role', Ref(name + 'EcsServiceRole'))
        Property('TaskDefinition', Ref(name + 'TaskDefinition'))
    end
  end
end
