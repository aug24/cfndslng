# frozen_string_literal: true

CfndslNg.add do
  def vpc

    Parameter('VPCCIDR') do
      Type 'String'
      Description 'IP Address range for the VPN connected VPC'
      MinLength '9'
      MaxLength '18'
      Default '10.1.0.0/16'
      AllowedPattern '(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})'
      ConstraintDescription 'must be a valid IP CIDR range of the form x.x.x.x/x.'
    end

    Resource('VPC') do
      Type 'AWS::EC2::VPC'
      Property('EnableDnsSupport', 'true')
      Property('EnableDnsHostnames', 'true')
      Property('CidrBlock', Ref('VPCCIDR'))
      stacktag
    end

    Output('VPCId') do
      Description('VPCId of the newly created VPC')
      Value(Ref('VPC'))
    end
    
  end
end
