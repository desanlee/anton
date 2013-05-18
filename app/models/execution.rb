class Execution < ActiveRecord::Base
  attr_accessible :bug, :note, :result, :sysconfig_id, :testcase_id, :user_id, :device_id
  
  belongs_to :testcase, class_name: "Testcase"
  belongs_to :sysconfig, class_name: "Sysconfig"
  belongs_to :user, class_name: "User"
  belongs_to :device, class_name: "Device"
  
  validates :testcase_id, :presence => true
  
  default_scope order: 'executions.created_at DESC'
end
