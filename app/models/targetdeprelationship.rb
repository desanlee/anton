class Targetdeprelationship < ActiveRecord::Base
  attr_accessible :device_id, :targetenv_id

  belongs_to :targetenv, class_name: "Targetenv"
  belongs_to :device, class_name: "Device"
end
