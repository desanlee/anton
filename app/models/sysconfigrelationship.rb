class Sysconfigrelationship < ActiveRecord::Base
  attr_accessible :device_id, :position, :sysconfig_id, :user_id
  
  belongs_to :sysconfig, class_name: "Sysconfig"
  belongs_to :device, class_name: "Device"
  
  def defaultposition
	if self.position != nil then return self.position
	else return -1
	end
  end
  
end
