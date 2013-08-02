class SearchesController < ApplicationController

  def index
	searchobject_id = session[:searchobject] 
	paracount = session[:count].to_i
	paraposition = session[:position].to_i
	
	@task = Task.find_by_id(params[:selecttask].to_i) if params[:selecttask] != nil
	@searchobject = Device.find_by_id(searchobject_id)
	
	@devices = Device.select{|d| d.devicetype != nil}
	if current_user != nil then
		if current_user.email == "ji.x.li@oracle.com" then
			@devices = @devices.sort_by{ |d| d[:devicetype_id]} 
		else
			@devices = @devices.select{|d| d.devicetype.devicecate == "Hardware"}.sort_by{ |d| d[:devicetype_id]} 
		end
	else
		@devices = @devices.select{|d| d.devicetype.devicecate == "Hardware"}.sort_by{ |d| d[:devicetype_id]} 
	end
	
	if @searchobject != nil then
		if !session[:count].empty? then
			@executions = @searchobject.realexecutionswithcount paracount
		elsif !session[:position].empty? then
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
	
	if @tasks != nil then
		@task = @tasks.first if @task == nil
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
	session[:count] = params[:count] 
	session[:position] = params[:position] 
	
	self.index
	render 'searches/index'
  end
  
end
