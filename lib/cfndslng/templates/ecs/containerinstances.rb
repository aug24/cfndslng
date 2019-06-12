# frozen_string_literal: true
  
CfndslNg.add do
  def containerinstances(name='')

    Parameter(name + 'EcsAmi') {
      Description 'ECS-Optimized AMI ID'
      Type 'AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>'
      Default '/aws/service/ecs/optimized-ami/amazon-linux/recommended/image_id'
    }

    Parameter(name + 'InstanceType') {
      Description 'EC2 instance type'
      Type 'String'
      Default 't2.micro'
    }

    Parameter(name + 'KeyName') {
      Type 'AWS::EC2::KeyPair::KeyName'
      Description 'Name of an existing EC2 KeyPair to enable SSH access to the ECS instances.'
    }

    Resource(name + 'ContainerInstances') do
      Type 'AWS::AutoScaling::LaunchConfiguration'
        Property('ImageId', Ref('EcsAmi'))
        Property('AssociatePublicIpAddress', true)
        Property('SecurityGroups', [ Ref('SGLoadBalancerToApp') ])
        Property('InstanceType', Ref('InstanceType'))
        Property('IamInstanceProfile', Ref('EC2InstanceProfile'))
        Property('KeyName', Ref('KeyName'))
        Property('UserData', {
          "Fn::Base64": {
            "Fn::Join": [
              "",
              [
                "#!/bin/bash -xe\n",
                "echo ECS_CLUSTER=", Ref('EcsCluster'), " >> /etc/ecs/ecs.config\n",
                "yum install -y aws-cfn-bootstrap\n",
                "/opt/aws/bin/cfn-signal -e $? ",
                "         --stack ", Ref('AWS::StackName'),
                "         --resource EcsAutoscalingGroup ",
                "         --region ", Ref('AWS::Region'),
                "\n"
              ]
            ]
          }
        })
    end
  end
end
