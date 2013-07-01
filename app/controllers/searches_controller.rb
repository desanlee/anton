class SearchesController < ApplicationController

  def index
	@devices = Device.all.sort_by{ |d| d[:devicetype_id]} 
	
	@executions = @searchobject.realexecutions
	@tasks = Array.new
	@executions.each do |e|
		@tasks = @tasks | e.tasks
	end
	
  end
  
  def search
	searchobject_id = params[:searchobject]
	@searchobject = Device.find_by_id(searchobject_id)
	
	self.index
	render 'searches/index'
  end
  
end
