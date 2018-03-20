# frozen_string_literal: true

module CfndslNg
  def self.add(&block)
    CfnDsl::CloudFormationTemplate.class_eval(&block)
    CfnDsl::ResourceDefinition.class_eval(&block)
  end
end
