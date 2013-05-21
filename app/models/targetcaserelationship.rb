class Targetcaserelationship < ActiveRecord::Base
  attr_accessible :targetenv_id, :testcase_id
  
  belongs_to :targetenv, class_name: "Targetenv"
  belongs_to :testcase, class_name: "Testcase"
end
