class Target < ActiveRecord::Base
  attr_accessible :name, :note, :task_id, :user_id
  
  belongs_to :task, class_name: "Task"
  has_many :targetenvs, class_name: "Targetenv"
  has_many :targetcases, class_name: "Targetcase"
end
