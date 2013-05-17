class TasksController < ApplicationController
  def paralist
    ['all','any','whole']
  end
  
  def index
	@tasklist = Task.all
	
	if @selecttask != nil then
		@task = Task.find_by_id(@selecttask)
		@targetlist = @task.targets if @task != nil
	end
	
	if @selecttarget != nil then
		@target = Target.find_by_id(@selecttarget)
		@targetenvlist = @target.targetenvs if @target != nil
		@targetcaselist = @target.targetcases if @target != nil
	end
	
	@devicetypes = Devicetype.all
	@envtypes = self.paralist
  end

  def selecttask
	@selecttask = params[:selecttask] 
	
	self.index
	render 'tasks/index'
  end
  
  def selecttarget
	@selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget] 
	
	self.index
	render 'tasks/index'
  end
  
  def addtask
	newtask = Task.new
	newtask.user_id = current_user.id
	newtask.name = params[:name]
	newtask.note = params[:note]
	newtask.save
	
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
  
  def selecttagertenv
    @selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtargetenvrelationship = Targetenvrelationship.new
	newtargetenvrelationship.targetenv_id = params[:selecttargetenv]
    newtargetenvrelationship.device_id = params[:selectdevice]
	newtargetenvrelationship.save
	
	self.index
	render 'tasks/index'	
  end
  
  def addtagertenv
    @selecttask = params[:selecttask]
	@selecttarget = params[:selecttarget]
	
	newtagertenv = Targetenv.new
	newtagertenv.envtype = params[:selectenvtype]
	newtagertenv.envpara = params[:envpara]
	newtagertenv.devicetype_id = params[:selectdevicetype]
	newtagertenv.target_id = params[:selecttarget]
	newtagertenv.save
	
	self.index
	render 'tasks/index'	
  end
  
  def selecttagertcase
	render 'tasks/index'	
  end
  
  def addtagertcase
	render 'tasks/index'	
  end
  
end
