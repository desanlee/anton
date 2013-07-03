class SearchesController < ApplicationController

  def index
	searchobject_id = session[:searchobject] 
	paracount = session[:count].to_i
	paraposition = session[:position].to_i
	
	@task = Task.find_by_id(params[:selecttask].to_i) if params[:selecttask] != nil
	@searchobject = Device.find_by_id(searchobject_id)
	
	@devices = Device.select{|d| d.devicetype != nil}
	@devices = @devices.select{|d| d.devicetype.devicecate == "Hardware"}.sort_by{ |d| d[:devicetype_id]} 
	
	if @searchobject != nil then
		if paracount > 0 then
			@executions = @searchobject.realexecutionswithcount paracount
		elsif paraposition >= 0 then
			@executions = @searchobject.realexecutionswithposition paraposition
		else
			@executions = @searchobject.realexecutions
		end
	end
	
	@tasks = Array.new
	if @executions != nil then
		@executions.each do |e|
			@tasks = @tasks | e.tasks
		end
	end
	
	if @task != nil then
		@selectedexecutions = @executions & @task.executions
		if @selectedexecutions != nil then
			@selectedexecutions = @selectedexecutions.select{ |e| e.testcase != nil }
			@selectedexecutions = @selectedexecutions.sort_by{ |e| [e.testcase.caseweightid, e.testcase.id] }
		end
	end
	
  end
  
  def search
	session[:searchobject] = params[:searchobject] if params[:searchobject] != nil
	session[:count] = params[:count] if params[:count] != nil
	session[:position] = params[:position] if params[:position] != nil
	
	self.index
	render 'searches/index'
  end
  
end
