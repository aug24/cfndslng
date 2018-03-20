# frozen_string_literal: true

CfndslNg.add do
  def private_bucket

    public_bucket.declare{
      Property('AccessControl', "Private")
      self
    }

  end

end
