# frozen_string_literal: true

CfndslNg.add do
  def vpn_gateway 

    Parameter('VPNAddress') do
      Type 'String'
      Description 'IP Address of your VPN device'
      MinLength '7'
      MaxLength '15'
      AllowedPattern '(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})'
      ConstraintDescription 'must be a valid IP address of the form x.x.x.x'
    end

    Resource('VPNGateway') do
      Type 'AWS::EC2::VPNGateway'
      Property('Type', 'ipsec.1')
      stacktag
    end

    Resource('VPNGatewayAttachment') do
      Type 'AWS::EC2::VPCGatewayAttachment'
      Property('VpcId', Ref('VPC'))
      Property('VpnGatewayId', Ref('VPNGateway'))
    end

    Resource('CustomerGateway') do
      Type 'AWS::EC2::CustomerGateway'
      Property('Type', 'ipsec.1')
      Property('BgpAsn', '65000') 
      Property('IpAddress', Ref('VPNAddress'))
      stacktag
    end

    Resource('PrivateRouteTable') do
      Type 'AWS::EC2::RouteTable'
        Property('VpcId', Ref('VPC'))
        stacktag
    end

    Resource('PrivateRoute') do
      Type 'AWS::EC2::Route'
      DependsOn 'VPNGatewayAttachment'
      Property('RouteTableId', Ref('PrivateRouteTable'))
      Property('DestinationCidrBlock', '0.0.0.0/0')
      Property('GatewayId', Ref('VPNGateway'))
    end

  end
end
