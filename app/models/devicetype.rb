class Devicetype < ActiveRecord::Base
  attr_accessible :name, :note, :positionname, :user_id
  has_many :devices, foreign_key: "devicetype_id"
  has_many :testcases, foreign_key: "devicetype_id"
  
  validates :name, :presence => true
end
