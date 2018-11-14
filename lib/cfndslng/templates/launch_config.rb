# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  
  def launch_template(file:)
    file = File.open(file + ".erb", "rb")
    file.read
  end
 

  def launch_config(name='', volume_size=8, template='launch_template')

    Parameter(name + 'KeyName') do
      Description 'The name of the EC2 Keypair with which to create instances'
      Default 'launch'
      Type 'String'
    end

    Parameter(name + "Ami") {
      Description "Amazon Machine Image"
      Type "String"
    }

    Parameter(name + "InstanceType") {
      Description "Type of EC2 instance to launch"
      Type "String"
    }

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

    Resource(name + 'InstanceProfile') do
      Type 'AWS::IAM::InstanceProfile'
      Property('Path', '/')
      Property('Roles', [Ref("InstanceRole")])
    end

    Resource(name + 'LaunchConfig') do
      Type 'AWS::AutoScaling::LaunchConfiguration'
      Property('KeyName', Ref(name + "KeyName"))
      Property('ImageId', Ref(name + "Ami"))
      Property('SecurityGroups', [ FnGetAtt("SGHostApp", "GroupId") ] )
      Property('InstanceType', Ref(name + "InstanceType"))
      Property('IamInstanceProfile', Ref(name + "InstanceProfile"))
      Property("BlockDeviceMappings", [
        {
         "DeviceName" => "/dev/sda1",
         "Ebs" => {
           "VolumeType" => "gp2",
           "VolumeSize" => volume_size
         }
        }
      ])
      Property('AssociatePublicIpAddress', 'True' )
      Property('UserData', FnBase64(
        FnJoin( "\n#", [ launch_template(file: template), Ref(name + "Version")] )
      ))
        
    end

  end
end
