class Testcase < ActiveRecord::Base
  attr_accessible :casecate, :casetype_id, :name, :devicetype_id, :caseweight_id, :steps, :user_id
  
  belongs_to :casetype, class_name: "Casetype"
  belongs_to :caseweight, class_name: "Caseweight"
  belongs_to :devicetype, class_name: "Devicetype"
  belongs_to :user, class_name: "User"
  belongs_to :targetmatrix, class_name: "Targetmatrix"
  
  has_many :executions, class_name: "Execution"
  
  has_many :reverse_targetcaserelationships, foreign_key: "testcase_id", class_name:  "Targetcaserelationship", dependent: :destroy
  has_many :targetcases, through: :reverse_targetcaserelationships, source: :targetcase
  
  validates :name, :presence => true
  
  default_scope order: 'testcases.name ASC'
  
  def longname
	if self.casetype != nil then
		self.casetype.name + " - " + self.executions.count.to_s + " - "  + self.name
	else
		"Notype - " + self.name
	end
  end
  
  def caseweightid
	if self.caseweight_id != nil then
		return self.caseweight_id
	else
		return 999
	end
  end
  
  def casecode
	return self.caseweightid.to_s + "-" + self.id.to_s
  end
  
  def caseweightname
	if self.caseweight_id != nil then
		return self.caseweight.name
	else
		return "Other Test Cases"
	end
  end
  
end
