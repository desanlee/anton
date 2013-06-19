class Blacklist < ActiveRecord::Base
  attr_accessible :erelationship_id, :targetenv_id, :trelationship_id
  
  belongs_to :targetenv, class_name: "Targetenv"
end
