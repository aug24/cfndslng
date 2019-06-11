# frozen_string_literal: true

CfndslNg.add do
  def private_subnet(name='')

    Parameter('Subnet' + name + 'CIDR') do
      Type 'String'
      Description 'IP Address range for the VPN connected Subnet'
      MinLength '9'
      MaxLength '18'
      AllowedPattern '(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})'
      ConstraintDescription 'must be a valid IP CIDR range of the form x.x.x.x/x.'
    end

    Resource('PrivateSubnet' + name) do
      Type 'AWS::EC2::Subnet'
      Property('VpcId', Ref('VPC'))
      Property('AvailabilityZone', FnJoin('', [ Ref('AWS::Region'), name.downcase ]))
      Property('CidrBlock', Ref('Subnet' + name + 'CIDR'))
      stacktag
    end

    Resource('PrivateSubnet' + name + 'RouteTableAssociation') do
      Type 'AWS::EC2::SubnetRouteTableAssociation'
      Property('SubnetId', Ref('PrivateSubnet' + name))
      Property('RouteTableId', Ref('PrivateRouteTable'))
    end

    Resource('PrivateSubnet' + name + 'NetworkAcl') do
      Type 'AWS::EC2::NetworkAcl'
      Property('VpcId', Ref('VPC'))
      stacktag
    end

    Resource('InboundPrivateSubnet' + name + 'NetworkAclEntry') do
      Type 'AWS::EC2::NetworkAclEntry'
      Property('NetworkAclId', Ref('PrivateSubnet' + name + 'NetworkAcl'))
      Property('RuleNumber', '100')
      Property('Protocol', '6')
      Property('RuleAction', 'allow')
      Property('Egress', 'false')
      Property('CidrBlock', '0.0.0.0/0')
      Property('PortRange', { 'From'  =>'0', 'To' => '65535' })
    end

    Resource('OutBoundPrivateSubnet' + name + 'NetworkAclEntry') do
      Type 'AWS::EC2::NetworkAclEntry'
      Property('NetworkAclId', Ref('PrivateSubnet' + name + 'NetworkAcl'))
      Property('RuleNumber', '100')
      Property('Protocol', '6')
      Property('RuleAction', 'allow')
      Property('Egress', 'true')
      Property('CidrBlock', '0.0.0.0/0')
      Property('PortRange', { 'From'  =>'0', 'To' => '65535' })
    end

    Resource('PrivateSubnet' + name + 'NetworkAclAssociation') do
      Type 'AWS::EC2::SubnetNetworkAclAssociation'
      Property('SubnetId', Ref('PrivateSubnet' + name))
      Property('NetworkAclId', Ref('PrivateSubnet' + name + 'NetworkAcl'))
    end
    
    Output('PrivateSubnet' + name) do
      Description('SubnetId of the VPN connected subnet')
      Value(Ref('PrivateSubnet' + name))
    end

  end
end
