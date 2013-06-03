class Taskexecution < ActiveRecord::Base
  attr_accessible :bug, :execution_id, :result, :task_id, :testcase_id, :user_id
  
  belongs_to :task, class_name: "Task"
  belongs_to :execution, class_name: "Execution"
  belongs_to :testcase, class_name: "Testcase"
end
