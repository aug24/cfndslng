#!/usr/bin/env ruby
require_relative '../lib/cfndslng.rb'

CloudFormation {
  http_alb
  lambda_function
  lambda_target
}
