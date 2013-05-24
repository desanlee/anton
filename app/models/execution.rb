class Execution < ActiveRecord::Base
  attr_accessible :bug, :note, :result, :sysconfig_id, :testcase_id, :user_id, :device_id
  
  belongs_to :testcase, class_name: "Testcase"
  belongs_to :sysconfig, class_name: "Sysconfig"
  belongs_to :user, class_name: "User"
  belongs_to :device, class_name: "Device"
  belongs_to :targetmatrix, class_name: "Targetmatrix"
  
  validates :testcase_id, :presence => true
  
  default_scope order: 'executions.created_at DESC'
  
  def realswconfig
	realdevicelist = Array.new
	realrelationship = Array.new
	self.sysconfig.sysconfigrelationships.each do |sr|
		if sr.device != nil then
			if sr.device.devicetype.devicecate == "Hardware" then
			elsif self.created_at >= sr.created_at  then
				realrelationship << sr 
			end
		end
	end
	tmprr = Sysconfigrelationship.new
	realrelationship.sort_by { |p| [p.device.devicetype, p.created_at] }.reverse.each do |rr|
		if tmprr.device == nil then
			realdevicelist << rr.device
			tmprr = rr
		elsif rr.device.devicetype.id != tmprr.device.devicetype.id then
			realdevicelist << rr.device
			tmprr = rr
		end
	end
	
	return realdevicelist.uniq
	
  end
  
  def realconfig
	realdevicelist = Array.new
	realrelationship = Array.new
	self.sysconfig.sysconfigrelationships.each do |sr|
		if sr.device != nil then
			if sr.device.devicetype.devicecate == "Hardware" then
				realdevicelist << sr.device
			elsif self.created_at >= sr.created_at  then
				realrelationship << sr 
			end
		end
	end
	tmprr = Sysconfigrelationship.new
	realrelationship.sort_by { |p| [p.device.devicetype, p.created_at] }.reverse.each do |rr|
		if tmprr.device == nil then
			realdevicelist << rr.device
			tmprr = rr
		elsif rr.device.devicetype != tmprr.device.devicetype then
			realdevicelist << rr.device
			tmprr = rr
		end
	end
	
	return realdevicelist.uniq
	
  end
  
  
end
