class System < ActiveRecord::Base
  attr_accessible :model, :name, :note, :pn, :user_id
  has_many :avlrelationships, foreign_key: "system_id", class_name:  "Avlrelationship", dependent: :destroy
  has_many :devices, through: :avlrelationships, :source => :device
  has_many :tasks, class_name: "Task"
  
  belongs_to :user, class_name: "User"
  
  validates :name, :presence => true
  
  default_scope order: 'systems.name ASC'
  
end
