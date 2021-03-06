class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :priviledges, class_name: "Priviledge"
  has_many :systems, class_name: "System"
  has_many :sysconfigs, class_name: "Sysconfig"
  has_many :executions, class_name: "Execution"
  has_many :testcases, class_name: "Testcase"
  has_many :targets, class_name: "Target"
  has_many :tasks, class_name: "Task"
  has_many :devices, class_name: "Device"
  
  has_many :teamrelationships, foreign_key: "lead_id", class_name: "Teamrelationship", dependent: :destroy
  has_many :engineers, through: :teamrelationships, :source => :engineer
  has_many :reverse_teamrelationships, foreign_key: "engineer_id", class_name: "Teamrelationship", dependent: :destroy
  has_many :leads, through: :reverse_teamrelationships, :source => :lead
  
  def charactors 
    mycharactors = Array.new
	self.priviledges.each do |p| 
		mycharactors << p.charactor 
	end
	mycharactors
  end
  
  def root?
    self.email == "root@oracle.com"
  end
  
  def manager?
    "manager".in? self.charactors
  end
  
  def lead?
    "lead".in? self.charactors
  end

  def engineer?
    "engineer".in? self.charactors
  end

  def visitor?
    "visitor".in? self.charactors
  end
  
  def name
	self.email.chomp("@oracle.com")
  end
  
end
