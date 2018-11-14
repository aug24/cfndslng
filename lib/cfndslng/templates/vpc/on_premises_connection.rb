# frozen_string_literal: true

CfndslNg.add do
  def on_premises_connection

    Parameter('OnPremiseCIDR') do
      Type 'String'
      Description 'IP Address range for your existing infrastructure'
      MinLength '9'
      MaxLength '18'
      Default '10.0.0.0/16'
      AllowedPattern '(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})'
      ConstraintDescription 'must be a valid IP CIDR range of the form x.x.x.x/x.'
    end
  
    Resource('VPNConnection') do
      Type 'AWS::EC2::VPNConnection'
        Property('Type', 'ipsec.1')
        Property('StaticRoutesOnly', 'true')
        Property('CustomerGatewayId', Ref('CustomerGateway'))
        Property('VpnGatewayId', Ref('VPNGateway'))
    end

    Resource('VPNConnectionRoute') do
      Type 'AWS::EC2::VPNConnectionRoute'
      Property('VpnConnectionId', Ref('VPNConnection'))
      Property('DestinationCidrBlock', Ref('OnPremiseCIDR'))
    end

  end
end
