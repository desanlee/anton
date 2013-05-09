class Sut < ActiveRecord::Base
  attr_accessible :name, :note, :spip, :system_id, :user_id, :holder_id
  
  has_many :sysconfigs, class_name: "Sysconfig"
  belongs_to :system, class_name: "System"
  
  validates :name, :presence => true
  
  default_scope order: 'suts.name ASC'
  
end
