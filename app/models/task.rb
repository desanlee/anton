class Task < ActiveRecord::Base
  attr_accessible :name, :note, :user_id
  
  belongs_to :user, class_name: "User"
  has_many :targets, class_name: "Target"
end
