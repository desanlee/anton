class Sysconfig < ActiveRecord::Base
  attr_accessible :autoupdate, :sut_id, :user_id
  
  belongs_to :sut, class_name: "Sut"
  belongs_to :user, class_name: "User"
  
  has_many :sysconfigrelationships, foreign_key: "sysconfig_id", class_name:  "Sysconfigrelationship", dependent: :destroy
  has_many :devices, through: :sysconfigrelationships, :source => :device
  
  has_many :executions, class_name: "Execution"
  
  def current_biosmode
	tmparray = Array.new
    self.sysconfigrelationships.each do |d|
		if d.device != nil then
			tmparray << d.device if d.device.biosmode?
		end
	end
	if tmparray.last!= nil then
		return tmparray.last.biosmode
	else
		return ""
	end
  end
  
  def current_bioses
	tmparray = Array.new
    self.sysconfigrelationships.each do |d|
		if d.device != nil then
			tmparray << d.device if d.device.spbios?
		end
	end
	tmparray
  end
  
  def current_bios
	self.current_bioses.last
  end
  
  def current_oses
	tmparray = Array.new
    self.sysconfigrelationships.each do |d|
		if d.device != nil then
			tmparray << d.device if d.device.os?
		end
	end
	tmparray
  end
  
  def current_os
	self.current_oses.last
  end
  
  def current_hwc
	tmparray = Array.new
	self.sysconfigrelationships.each do |d|
		if d.device!= nil then
			tmparray << d if d.device.devicetype.devicecate == "Hardware"
		end
	end
	return tmparray.sort_by{ |d| d.device_id}
  end
  
  def current_swc
	realrelationship = Array.new
	swc = Array.new
	self.sysconfigrelationships.each do |sr|
		if sr.device != nil then
			if sr.device.devicetype.devicecate != "Hardware" then
				realrelationship << sr 
			end
		end
	end
	tmprr = Sysconfigrelationship.new
	realrelationship.sort_by { |p| [p.device.devicetype_id, p.position] }.reverse.each do |rr|
		if tmprr.device == nil then
			swc << rr
			tmprr = rr
		elsif rr.device.devicetype != tmprr.device.devicetype then
			swc << rr
			tmprr = rr
		end
	end
	return swc
  end
  
  def sutname
	return self.sut.name + "-" + self.id.to_s
  end
end
