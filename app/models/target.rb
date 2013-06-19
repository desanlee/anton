class Target < ActiveRecord::Base
  attr_accessible :name, :note, :task_id, :user_id, :targetindex
  
  belongs_to :task, class_name: "Task"
  belongs_to :user, class_name: "User"
  has_many :targetenvs, class_name: "Targetenv", dependent: :destroy
  has_many :targetcases, class_name: "Targetcase"
  
  default_scope order: 'targets.targetindex ASC'
  
  def env
	environ = self.targetenvs.first if self.targetenvs != nil
	if environ == nil then
		environ = Targetenv.new
		environ.target_id = self.id
		environ.save
	end
	return environ
  end
  
  def percentage
	if self.env.totalweight == 0 then 
		return 0 
	else
		return 100 * self.env.finishedweight / self.env.totalweight
	end
  end
  
end
