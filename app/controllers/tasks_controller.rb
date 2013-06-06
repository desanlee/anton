class TasksController < ApplicationController
  def paralist
    ['all','any','whole']
  end
  
  def selectuser
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	transfertarget = Target.find_by_id(@selecttarget)
	transfertarget.update_attributes(:user_id => params[:selectuser]) if transfertarget != nil

	self.index
	render 'tasks/index'
  end
  
  def edit
    @task = Task.find(params[:id])
	render :layout => "justapage"
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
  def index
  
	@selecttask = session[:selecttask]
	@selecttarget = session[:selecttarget]
	
	if current_user.lead? then 
		@tasklist = current_user.tasks 
	else
		@tasklist = Array.new
		current_user.targets.each do |ta|
			@tasklist << ta.task
			@tasklist = @tasklist.uniq
		end
	end
	@systems = System.all
	@testcases = Testcase.select{|c| c[:casetype_id] != nil}.sort_by{ |c| c[:casetype_id]}
	@users = User.all
	
	if @selecttask == nil then
		@task = Task.first 
		@selecttask = @task.id if @task != nil
	else
		@task = Task.find_by_id(@selecttask)
		if @task == nil then
			@task = Task.first 
			@selecttask = @task.id if @task != nil
		end
	end
	
	@taskexecutions = @task.taskexecutions
	
	@devicetypes = Devicetype.all
	@devices = @task.system.devices.sort_by{ |d| d[:devicetype_id]} if @task.system != nil
	@taskobjects = @task.taskobjects
	if current_user.lead? then
		@targetlist = @task.targets
	else
		@targetlist = @task.targets.select { |ta| ta.user_id == current_user.id } if @task != nil
	end
	

	if @selecttarget == nil then
		@target = @targetlist.first if @targetlist != nil if @task != nil
		@selecttarget = @target.id if @target != nil
	else
		@target = Target.find_by_id(@selecttarget)
	end
	
	if @target != nil then
		@targetenv = @target.targetenvs.first 
		
		if @targetenv != nil then
			@envdevices = @targetenv.targetenvrelationships
			@envdepdevices = @targetenv.targetdeprelationships
			@envtestcases = @targetenv.targetcaserelationships
			@thematrix = @targetenv.targetmatrixes 
		else
			@targetenv = Targetenv.new
			@targetenv.target_id = @target.id
			@targetenv.save
			@envdevices = @targetenv.targetenvrelationships
			@envdepdevices = @targetenv.targetdeprelationships
			@envtestcases = @targetenv.targetcaserelationships
			@thematrix = @targetenv.targetmatrixes 
		end
	end
	
	@envtypes = self.paralist
  end

  def calculate
	@totalcases = 0
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	@task = Task.find_by_id(@selecttask)
	@target = Target.find_by_id(@selecttarget)
	
	@task.update_time = Time.now
	@task.save
	
	allexecutions = Array.new
	@task.taskobjects.each do |d|
		d.executioncount = 0
		d.device.realexecutions.each do |re|
			allexecutions << re
			d.executioncount += 1
		end
		d.save
	end
	
	allexecutions = allexecutions.uniq
	Taskexecution.all.each do |t|
		t.destroy
	end
	allexecutions.each do |eachexecution|
		taskexecution = Taskexecution.new
		taskexecution.task_id = @task.id
		taskexecution.execution_id = eachexecution.id
		taskexecution.user_id = eachexecution.user_id
		taskexecution.testcase_id = eachexecution.testcase_id
		taskexecution.result = eachexecution.result
		taskexecution.bug = eachexecution.bug
		taskexecution.save
	end
	
	@task.targets.each do |target|
		target.targetenvs.each do |te|
			te.targetmatrixes.each do |tm|
				tm.destroy
		end end
		
		te = target.targetenvs.first
		realexecutions = Array.new
		if te != nil then 
			te.testcases.each do |c|
				allexecutions.each do |ex|
					if ex.testcase != nil then
						realexecutions << ex if ex.testcase.id = c.id
					end
				end
			end
			realexecutions = realexecutions.uniq
			te.devices.each do |d|
				realexecutions.each do |ex|
					if ex.realconfig.include? d then 
						te.depdevices.each do |dd|
							if ex.realconfig.include? dd then 
								matrixitem = Targetmatrix.new
								matrixitem.targetenv_id = te.id
								matrixitem.device_id = d.id
								matrixitem.envdevice_id = dd.id
								matrixitem.testcase_id = ex.testcase_id
								matrixitem.execution_id = ex.id
								matrixitem.result = ex.result
								matrixitem.bug = ex.bug
								matrixitem.save
							end
						end
					end
				end
			end
		end
	end
	
	self.index
	render 'tasks/index'
  end
  
  def selecttask
	@selecttask = params[:selecttask] 
	session[:selecttask] = @selecttask
	@selecttarget = nil
	session[:selecttarget] = nil
	
	self.index
	render 'tasks/index'
  end
  
  def addtask
	newtask = Task.new
	newtask.user_id = current_user.id
	newtask.name = params[:name]
	newtask.note = params[:note]
	newtask.system_id = params[:selectsystem]
	newtask.save
	
	session[:selecttask] = newtask.id
	
	self.index
	render 'tasks/index'	
  end
  
  def addtaskobject
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtaskobject = Taskobject.new
	newtaskobject.user_id = current_user.id
	newtaskobject.task_id = @selecttask
	newtaskobject.device_id = params[:taskobject]
	newtaskobject.save
	
	self.index
	render 'tasks/index'
  end
  
  def selecttarget
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget] 
	
	session[:selecttarget] = @selecttarget
	
	self.index
	render 'tasks/index'
  end
  
  def addtarget
	@selecttask = params[:selecttask]
	
	newtarget = Target.new
	newtarget.user_id = current_user.id
	newtarget.task_id = @selecttask
	newtarget.name = params[:name]
	newtarget.note = params[:note]
	newtarget.save
	
	session[:selecttarget] = newtarget.id
	
	@selecttarget = newtarget.id
	
	self.index
	render 'tasks/index'	
  end
  
  def addtagertenv
    @selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtagertenv = Targetenv.new
	newtagertenv.target_id = params[:selecttarget]
	newtagertenv.save
	
	self.index
	render 'tasks/index'	
  end
  
  def addtestcase
  	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtargettestcase = Targetcaserelationship.new
	newtargettestcase.targetenv_id = params[:selecttargetenv]
	newtargettestcase.testcase_id = params[:selecttestcase]
	newtargettestcase.save
	
	self.index						
	render 'tasks/index'	
  end
  
  def adddevice
  	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtargetdevice = Targetenvrelationship.new
	newtargetdevice.targetenv_id = params[:selecttargetenv]
	newtargetdevice.device_id = params[:selectdevice]
	newtargetdevice.save
	
	self.index						
	render 'tasks/index'	
  end
  
  def adddepdevice
  	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtargetdevice = Targetdeprelationship.new
	newtargetdevice.targetenv_id = params[:selecttargetenv]
	newtargetdevice.device_id = params[:selectdevice]
	newtargetdevice.save
	
	self.index						
	render 'tasks/index'	
  end
  
  def addtdev
	render 'tasks/index'	
  end
  
  def twiki
	@selecttask = params[:selecttask]
	@task = Task.find_by_id(@selecttask)
	
	@taskobjects = @task.taskobjects
	@targetlist = @task.targets
	
	@sysconfiglist = Array.new
	@task.taskexecutions.each do |te|
		if te.execution != nil then
			if !@sysconfiglist.include? te.execution.sysconfig then
				@sysconfiglist << te.execution.sysconfig
			end
		end
	end
	
	render :layout => "justapage"
  end
  
  def destroy
    @task = Task.find(params[:id])
	@task.destroy
	redirect_to :tasks
  end
  
end
