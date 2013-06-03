class Task < ActiveRecord::Base
  attr_accessible :name, :note, :user_id, :system_id
  
  belongs_to :user, class_name: "User"
  belongs_to :system, class_name: "System"
  has_many :targets, class_name: "Target", dependent: :destroy
  has_many :taskobjects, class_name: "Taskobject", dependent: :destroy
  has_many :devices, through: :taskobjects, source: :device
  has_many :taskexecutions, class_name: "Taskexecution", dependent: :destroy
  
  validates :system_id, :presence => true
  
end
