# frozen_string_literal: true

CfndslNg.add do
  def stacktag 
    Property("Tags", [{ "Key"   => 'Stack', "Value" => Ref("AWS::StackName") } ] )
  end
end
