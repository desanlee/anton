class Taskobject < ActiveRecord::Base
  attr_accessible :name, :note, :task_id, :user_id, :device_id
  belongs_to :user, class_name: "User"
  belongs_to :task, class_name: "Task"
  belongs_to :device, class_name: "Device"
 
end
