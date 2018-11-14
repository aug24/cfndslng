# frozen_string_literal: true

# Usage
#
# AssociatePublicIpAddress is not specified below.  Use public_launch_config and private_launch_config.

CfndslNg.add do
  def cloud_init(name='LaunchConfig', filename='CloudInit')
    puppet
    s3_gpg

    cloud_init_content = File.open(filename, "r") {|io| io.read}

    Resource("#{name}") {
      UserData FnBase64(FnSub(cloud_init_content,
#        "#!/bin/bash -xe
#apt-get update
#apt-get install --force-yes -y bgch-bootstrap=*
#/usr/lib/bgch/bootstrap/bootstrapper.sh -S ${keybucket}/ops-puppet-${environment}.tar ${repo}/${product}:${environment}:${role}:${generation}",
        {
          "keybucket" =>   Ref("KeyBucket"),
          "repo" =>        Ref("PuppetRepository"),
          "product" =>     Ref("PuppetProduct"),
          "environment" => Ref("PuppetEnvironment"),
          "role" =>        Ref("PuppetRole"),
          "generation" =>  Ref("Generation")
        }
      ))
    }

  end
end
