class Sysconfig < ActiveRecord::Base
  attr_accessible :autoupdate, :sut_id, :user_id
  
  belongs_to :sut, class_name: "Sut"
  belongs_to :user, class_name: "User"
  
  has_many :sysconfigrelationships, foreign_key: "sysconfig_id", class_name:  "Sysconfigrelationship", dependent: :destroy
  has_many :devices, through: :sysconfigrelationships, :source => :device
  
  has_many :executions, class_name: "Execution"
  
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
  
end
