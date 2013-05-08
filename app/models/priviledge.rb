class Priviledge < ActiveRecord::Base
  attr_accessible :charactor, :user_id
  
  belongs_to :user, class_name: "User"
end
