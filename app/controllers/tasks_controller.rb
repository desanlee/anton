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
	@testcases = Testcase.all
	@users = User.all
	
	if @selecttask == nil then
		@task = Task.first 
		@selecttask = @task.id if @task != nil
	else
		@task = Task.find_by_id(@selecttask)
	end
	@devicetypes = Devicetype.all
	@devices = @task.system.devices if @task.system != nil
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
	@targetenvlist = Array.new
	@targetenvlist << @target.env if @target != nil
	
	
	@envtypes = self.paralist
  end

  def calculate
	@totalcases = 0
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	@task = Task.find_by_id(@selecttask)
	@target = Target.find_by_id(@selecttarget)
	
	@target.targetenvs.each do |te|
		te.targetmatrixes.each do |tm|
			tm.destroy
	end end
	
	allexecutions = Array.new
	@task.devices.each do |d|
		d.realexecutions.each do |re|
			allexecutions << re
		end
	end
	
	@target.targetenvs.each do |te|
		te.devices.each do |d|
			allexecutions.uniq.each do |ex|
				if ex.realconfig.include? d then 
					matrixitem = Targetmatrix.new
					matrixitem.targetenv_id = te.id
					matrixitem.device_id = d.id
					matrixitem.testcase_id = ex.testcase_id
					matrixitem.execution_id = ex.id
					matrixitem.save
					
					ex.realconfig.each do |rcd|
						realconfig = Realconfig.new
						realconfig.targetmatrix_id = matrixitem.id
						realconfig.device_id = rcd.id
						realconfig.devicename = rcd.name
						realconfig.devicetype = rcd.devicetype_id
						realconfig.save
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
  
  def destroy
    @task = Task.find(params[:id])
	@task.destroy
	redirect_to :tasks
  end
  
end
