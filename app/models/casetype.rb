class Casetype < ActiveRecord::Base
  attr_accessible :name, :note, :user_id
  has_many :testcases, foreign_key: "casetype_id"
end
