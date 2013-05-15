class Targetcaserelationship < ActiveRecord::Base
  attr_accessible :targetcase_id, :testcase_id
  
  belongs_to :targetcase, class_name: "Targetcase"
  belongs_to :testcase, class_name: "Testcase"
end
