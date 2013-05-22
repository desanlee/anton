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
end
