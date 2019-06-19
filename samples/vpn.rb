#!/usr/bin/env ruby
require_relative '../lib/cfndslng.rb'

CloudFormation {
  vpc
  internet_gateway
  outbound_private_route
  private_subnet('A')	
  private_subnet('B')	

}
