class Targetenv < ActiveRecord::Base
  attr_accessible :envpara, :envtype, :target_id
  
  belongs_to :target, class_name: "Target"
  belongs_to :devicetype, class_name: "Devicetype"
  has_many :targetenvrelationships, class_name: "Targetenvrelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :targetdeprelationships, class_name: "Targetdeprelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :targetcaserelationships, class_name: "Targetcaserelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :devices, through: :targetenvrelationships, source: :device
  has_many :depdevices, through: :targetdeprelationships, source: :device
  has_many :testcases, through: :targetcaserelationships, source: :testcase
  has_many :targetmatrixes, class_name: "Targetmatrix"
  
  def targetcount
	return self.targetenvrelationships.count * self.targetenvrelationships.count
  end
  
  def finishedcount
	count = 0
	self.devices.uniq.each do |d|
		self.depdevices.uniq.each do |t|
			count += 1 if ! self.targetmatrixes.select {|m| m.device_id == d.id and m.envdevice_id == t.id}.empty?
		end
	end
	return count
  end
  
end
