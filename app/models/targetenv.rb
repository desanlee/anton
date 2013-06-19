class Targetenv < ActiveRecord::Base
  attr_accessible :envpara, :envtype, :target_id
  
  belongs_to :target, class_name: "Target"
  belongs_to :devicetype, class_name: "Devicetype"
  has_many :targetenvrelationships, class_name: "Targetenvrelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :targetdeprelationships, class_name: "Targetdeprelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :targetcaserelationships, class_name: "Targetcaserelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :blacklists, class_name: "Blacklist", foreign_key: "targetenv_id", dependent: :destroy

  has_many :devices, through: :targetenvrelationships, source: :device
  has_many :depdevices, through: :targetdeprelationships, source: :device
  has_many :testcases, through: :targetcaserelationships, source: :testcase
  has_many :targetmatrixes, class_name: "Targetmatrix"
  
  def totalcount
	count = 0
	self.targetenvrelationships.each do |d|
		self.targetdeprelationships.each do |t|
			if self.blacklists.select{|bl| bl.trelationship_id == d.id && bl.erelationship_id == t.id }.empty? then
				count += 1 
			end
		end
	end
	return count
  end
  
  def finishedcount
	count = 0
	self.targetenvrelationships.each do |d|
		self.targetdeprelationships.each do |t|
			if self.blacklists.select{|bl| bl.trelationship_id == d.id && bl.erelationship_id == t.id }.empty? then
				count += 1 if ! self.targetmatrixes.select {|m| m.device_id == d.device_id and m.envdevice_id == t.device_id}.empty?
			end
		end
	end
	return count
  end
  
  def totalweight
	weight = 0
	self.labellists.each do |label|
		weight += label.weight * self.totalcount
	end
	return weight
  end
  
  def finishedweight
	weight = 0
	self.targetenvrelationships.each do |d|
		self.targetdeprelationships.each do |t|
			if self.blacklists.select{|bl| bl.trelationship_id == d.id && bl.erelationship_id == t.id }.empty? then
				testcases = self.targetmatrixes.select {|m| m.device_id == d.device_id and m.envdevice_id == t.device_id}
				if ! testcases.empty? then
					self.labellists.each do |label|
						weight += label.weight if !testcases.select {|m| m.testcase.caseweight_id == label.id}.empty?
					end
				end
			end
		end
	end
	return weight
  end
  
  def labellists
	lists = Array.new
	tmplabel = Caseweight.new
	self.testcases.each do |t|
		if t.caseweight != nil then
			if t.caseweight != tmplabel then
				tmplabel = t.caseweight
				lists << tmplabel
			end
		end
	end
	return lists
  end
  
end
