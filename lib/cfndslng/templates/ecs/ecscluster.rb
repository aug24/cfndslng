# frozen_string_literal: true
  
CfndslNg.add do
  def ecscluster(name='')
    Resource(name + 'EcsCluster') do
      Type 'AWS::ECS::Cluster'
    end
  end
end
