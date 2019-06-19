# frozen_string_literal: true

# Usage

# Adding replacing update to a cloudformation stack will result in a new ASG being created with
# the new launch config.
# The new ASG will then launch instances, and wait for success signals. The below is configured to
# require at least 'MinSize' success signals.
# Once enough are signals are received, the old ASG (and all its instances) is killed.
#
# In order for this to work:
#  1) Instances must send a success signal!  This is your responsibility!
#  2) This requires an invocation of aws cli or cfn-signal cli
#  3) This requires a policy for the instance allowing sending the signal
#
# 1 & 2 must be done at the end of cloud init, or after some criteria are met.

CfndslNg.add do
  def autoscaling_group_policy_for_replacing_update(name="", count="MinSize")

    Resource(name + "ASG") {
      CreationPolicy("AutoScalingCreationPolicy", { "MinSuccessfulInstancesPercent" => 100 })
      CreationPolicy("ResourceSignal", { "Timeout" => "PT20M", "Count" => Ref(count) } )
      UpdatePolicy("AutoScalingReplacingUpdate", { "WillReplace" => true })
    }

    #       "Resource" => FnJoin("/", [ Ref('AWS::StackName'), "*" ] )
    Resource("#{name}SignalResourcePolicy") do
      Type 'AWS::IAM::Policy'
      Property('PolicyName', "#{name}SignalResourcePolicy")
      Property('PolicyDocument', {
        "Id"        => "#{name}SignalResourcePolicy",
        "Statement" => [
          {
           "Effect" => "Allow",
           "Action" => [
             "cloudformation:SignalResource",
           ],
           "Resource" => "*" 
          }
        ],
        "Version"   => "2008-10-17"
      })
      Property('Roles', [Ref(name + "InstanceRole")])
    end

  end
end
