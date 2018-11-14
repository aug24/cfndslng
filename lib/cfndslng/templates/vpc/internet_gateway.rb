# frozen_string_literal: true

CfndslNg.add do
  def internet_gateway

    Resource('InternetGateway') do
      Type 'AWS::EC2::InternetGateway'
    end

    Resource('PrivateRouteTable') do
      Type 'AWS::EC2::RouteTable'
      Property('VpcId', Ref('VPC'))
      stacktag
    end
    
    Resource('InternetGatewayAttachment') do
      Type 'AWS::EC2::VPCGatewayAttachment'
      Property('InternetGatewayId', Ref('InternetGateway'))
      Property('VpcId', Ref('VPC'))
    end   
    
    Resource('InternetRoute') do
      Type 'AWS::EC2::Route'
      Property('RouteTableId', Ref('PrivateRouteTable'))
      Property('DestinationCidrBlock', '0.0.0.0/0')
      Property('GatewayId', Ref('InternetGateway'))
      DependsOn [ 'InternetGateway' ]
    end

  end
end
