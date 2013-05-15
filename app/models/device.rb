class Device < ActiveRecord::Base
  attr_accessible :countnum, :devicecate, :devicetype_id, :model, :name, :note, :pn, :user_id

  has_many :reverse_avlrelationships, foreign_key: "device_id", class_name:  "Avlrelationship", dependent: :destroy
  has_many :systems, through: :reverse_avlrelationships, :source => :system

  belongs_to :devicetype, class_name: "Devicetype"
  
  has_many :reverse_sysconfigrelationships, foreign_key: "device_id", class_name:  "Sysconfigrelationship", dependent: :destroy
  has_many :sysconfigs, through: :reverse_sysconfigrelationships, :source => :sysconfig
  has_many :executions, class_name: "Execution"

  has_many :reverse_targetenvrelationships, foreign_key: "device_id", class_name:  "Targetenvrelationship", dependent: :destroy
  has_many :targetenvs, through: :reverse_targetenvrelationships, source: :targetenv
  
  validates :name, :presence => true
  
  default_scope order: 'devices.name ASC'
end
