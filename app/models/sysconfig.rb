class Sysconfig < ActiveRecord::Base
  attr_accessible :autoupdate, :sut_id, :user_id
  
  belongs_to :sut, class_name: "Sut"
  belongs_to :user, class_name: "User"
  
  has_many :sysconfigrelationships, foreign_key: "sysconfig_id", class_name:  "Sysconfigrelationship", dependent: :destroy
  has_many :devices, through: :sysconfigrelationships, :source => :device
  
  has_many :executions, class_name: "Execution"
  
end
