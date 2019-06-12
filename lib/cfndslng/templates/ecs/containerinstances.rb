# frozen_string_literal: true
  
# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do

  def launch_template(files:)
    template = ''
    files.each { |file| 
      file = File.open(file + ".erb", "rb")
      template += (file.read + "\n")
    }
    template
  end
 
  def containerinstances(name='')

    Parameter(name + 'KeyName') {
      Description 'The name of the EC2 Keypair with which to create instances'
      Default 'launch'
      Type 'AWS::EC2::KeyPair::KeyName'
    }

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

    Resource(name + 'LaunchConfig') do
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

    Resource(name + 'InstanceRole') do
      Type 'AWS::IAM::Role'
      Property('AssumeRolePolicyDocument', {
        "Id"        => "EIPManagementRole",
        "Version" => "2012-10-17",
        "Statement" => {
          "Effect" => "Allow",
          "Principal" => {"Service" => "ec2.amazonaws.com"},
          "Action" => "sts:AssumeRole"
        }
      })
    end

    Resource(name + 'EC2InstanceProfile') do
      Type 'AWS::IAM::InstanceProfile'
        Property('Path', '/')
        Property('Roles', [ Ref('InstanceRole') ])
    end
  end
end
