class Testcase < ActiveRecord::Base
  attr_accessible :casecate, :casetype_id, :name, :devicetype_id, :steps, :user_id
  
  belongs_to :casetype, class_name: "Casetype"
  belongs_to :devicetype, class_name: "Devicetype"
  belongs_to :user, class_name: "User"
  
  has_many :executions, class_name: "Execution"
  
  has_many :reverse_targetcaserelationships, foreign_key: "testcase_id", class_name:  "Targetcaserelationship", dependent: :destroy
  has_many :targetcases, through: :reverse_targetcaserelationships, source: :targetcase
  
  validates :name, :presence => true
  
  default_scope order: 'testcases.name ASC'
  
  def longname
	if self.devicetype != nil then
		self.devicetype.name + " - " + self.name
	else
		"Notype - " + self.name
	end
  end
  
end
