# frozen_string_literal: true

CfndslNg.add do
  def puppet
    Parameter('PuppetRepository') do
      Type 'String'
    end

    Parameter('PuppetProduct') do
      Type 'String'
    end

    Parameter('PuppetEnvironment') do
      Type 'String'
    end

    Parameter('PuppetRole') do
      Type 'String'
    end

  end
end

