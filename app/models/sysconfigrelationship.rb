class Sysconfigrelationship < ActiveRecord::Base
  attr_accessible :device_id, :position, :sysconfig_id, :user_id
  
  belongs_to :sysconfig, class_name: "Sysconfig"
  belongs_to :device, class_name: "Device"
end
