class Caseweight < ActiveRecord::Base
  attr_accessible :name, :note, :user_id, :weight, :labelindex
  
  default_scope order: 'caseweights.labelindex ASC'
end
