class Testcase < ActiveRecord::Base
  attr_accessible :casecate, :casetype_id, :name, :devicetype_id, :steps, :user_id
  
  belongs_to :casetype, class_name: "Casetype"
  belongs_to :devicetype, class_name: "Devicetype"
  belongs_to :user, class_name: "User"
  
  has_many :executions, class_name: "Execution"
  
  validates :name, :presence => true
  
  default_scope order: 'testcases.name ASC'
  
end
