class Targetmatrix < ActiveRecord::Base
  attr_accessible :device_id, :execution_id, :targetenv_id, :testcase_id, :update_time
  
  belongs_to :targetenv, class_name: "Targetenv"
  belongs_to :execution, class_name: "Execution"
  
end
