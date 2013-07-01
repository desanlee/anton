class Task < ActiveRecord::Base
  attr_accessible :name, :note, :user_id, :system_id
  
  belongs_to :user, class_name: "User"
  belongs_to :system, class_name: "System"
  has_many :targets, class_name: "Target", dependent: :destroy
  has_many :taskobjects, class_name: "Taskobject", dependent: :destroy
  has_many :devices, through: :taskobjects, source: :device
  has_many :taskexecutions, class_name: "Taskexecution", dependent: :destroy
  has_many :executions, through: :taskexecutions, source: :execution
  
  validates :system_id, :presence => true
  
  def totalcount
	count = 0
	if self.targets != nil then
		self.targets.each do |target|
			if target.targetenvs != nil then
				count += target.targetenvs.first.totalcount
			end
		end
	end
	return count
  end
  
  def finishedcount
	count = 0
	if self.targets != nil then
		self.targets.each do |target|
			if target.targetenvs != nil then
				count += target.targetenvs.first.finishedcount
			end
		end
	end
	return count
  end
  
  def totalweight
	count = 0
	if self.targets != nil then
		self.targets.each do |target|
			if target.targetenvs != nil then
				count += target.targetenvs.first.totalweight
			end
		end
	end
	return count
  end
  
  def finishedweight
	count = 0
	if self.targets != nil then
		self.targets.each do |target|
			if target.targetenvs != nil then
				count += target.targetenvs.first.finishedweight			
			end
		end
	end
	return count
  end
  
  def percentage
	if self.totalcount == 0 then 
		return 0 
	else
		return 100 * self.finishedcount / self.totalcount
	end
  end
  
  def active?
	if self.status != -1 then
		return true
	else
		return false
	end
  end
  
  def enable
	self.status = 1
	self.save
	self.targets.each do |t|
		t.status = 1
		t.save
	end
  end
  
  def disable
	self.status = -1
	self.save
	self.targets.each do |t|
		t.status = -1
		t.save
	end
  end
  
end
