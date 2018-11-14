# frozen_string_literal: true

CfndslNg.add do
  def https_elb

    http_elb.declare{
      Property("Listeners" , [
        {
          "LoadBalancerPort" => Ref("PublicPort"),
          "InstancePort" => Ref("PrivatePort"),
          "Protocol" => "HTTPS",
          "SSLCertificateId" => Ref("TLSCert")
        }
      ])
      self
    }
  end
end
