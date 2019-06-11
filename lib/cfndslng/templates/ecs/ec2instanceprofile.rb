# frozen_string_literal: true
  
CfndslNg.add do
  def ec2instanceprofile(name='')
    Resource(name + 'EC2InstanceProfile') do
      Type 'AWS::IAM::InstanceProfile'
        Property('Path', '/')
        Property('Roles', [ Ref('EC2Role') ])
    end
  end
end
