# frozen_string_literal: true

CfndslNg.add do
  def private_bucket(name='')

    public_bucket(name).declare{
      Property('AccessControl', "Private")
      self
    }

  end

end
