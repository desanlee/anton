class Targetcase < ActiveRecord::Base
  attr_accessible :casepara, :casetype, :target_id
  
  belongs_to :target, class_name: "Target"
  has_many :targetcaserelationships, class_name: "Targetcaserelationship", foreign_key: "targetcase_id",  dependent: :destroy
  has_many :testcases, through: :targetcaserelationships, source: :testcase
  
end
