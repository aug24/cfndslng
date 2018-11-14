# frozen_string_literal: true

CfndslNg.add do
  def common_statements
    Parameter('Generation') do
      Description 'The generation (blue/green etc) of the stack'
      Type 'String'
    end

    Parameter('MostRecentlyUpsertedBy') do
      Description 'The version of the stack that is deployed'
      Type 'String'
    end

    Parameter('DeployedVersion') do
      Description 'The version of the stack that is deployed'
      Type 'String'
    end

    Output('DeployedVersion') do
      Value Ref('DeployedVersion')
      Description 'The version of the stack that is deployed'
    end

    Output('MostRecentlyUpsertedBy') do
      Value Ref('MostRecentlyUpsertedBy')
      Description 'The user who most recently upserted this stack'
    end
  end
end
