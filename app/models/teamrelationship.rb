class Teamrelationship < ActiveRecord::Base
  attr_accessible :engineer_id, :lead_id
  
  belongs_to :lead, class_name: "User"
  belongs_to :engineer, class_name: "User"
end
