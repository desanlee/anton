class Targetenv < ActiveRecord::Base
  attr_accessible :envpara, :envtype, :target_id
  
  belongs_to :target, class_name: "Target"
  belongs_to :devicetype, class_name: "Devicetype"
  has_many :targetenvrelationships, class_name: "Targetenvrelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :targetcaserelationships, class_name: "Targetcaserelationship", foreign_key: "targetenv_id", dependent: :destroy
  has_many :devices, through: :targetenvrelationships, source: :device
  has_many :testcases, through: :targetcaserelationships, source: :testcase
  has_many :targetmatrixes, class_name: "Targetmatrix"
end
