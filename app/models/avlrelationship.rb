class Avlrelationship < ActiveRecord::Base
  attr_accessible :device_id, :maxnum, :note, :system_id, :user_id
  
  belongs_to :device, class_name: "Device"
  belongs_to :system, class_name: "System"
end
