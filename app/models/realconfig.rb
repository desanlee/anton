class Realconfig < ActiveRecord::Base
  attr_accessible :device_id, :devicename, :devicetype, :targetmatrix_id
  
  belongs_to :device, class_name: "Device"
  belongs_to :targetmatrix, class_name: "Targetmatrix"
  
end
