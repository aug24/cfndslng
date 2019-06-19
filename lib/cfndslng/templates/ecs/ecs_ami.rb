# frozen_string_literal: true
  
# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do

  def ecs_ami(name='')

    Parameter(name + "Ami") {
      Description 'ECS-Optimized AMI ID'
      Type 'AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>'
      Default '/aws/service/ecs/optimized-ami/amazon-linux/recommended/image_id'
    }

  end
end
