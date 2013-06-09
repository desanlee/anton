class Task < ActiveRecord::Base
  attr_accessible :name, :note, :user_id, :system_id
  
  belongs_to :user, class_name: "User"
  belongs_to :system, class_name: "System"
  has_many :targets, class_name: "Target", dependent: :destroy
  has_many :taskobjects, class_name: "Taskobject", dependent: :destroy
  has_many :devices, through: :taskobjects, source: :device
  has_many :taskexecutions, class_name: "Taskexecution", dependent: :destroy
  
  validates :system_id, :presence => true
  
  def targetcount
	count = 0
	if self.targets != nil then
		self.targets.each do |target|
			if target.targetenvs != nil then
				count += target.targetenvs.first.targetcount
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
end
