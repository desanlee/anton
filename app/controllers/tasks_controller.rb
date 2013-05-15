class TasksController < ApplicationController
  def paralist
    ['all','any']
  end
  
  def index
	@tasklist = Task.all
	
	if @selecttask != nil then
		tmptask = Task.find_by_id(@selecttask)
		@targetlist = tmptask.targets if tmptask != nil
	end
	
	if @selecttarget != nil then
		tmptarget = Target.find_by_id(@selecttarget)
		@targetenvlist = tmptarget.targetenvs if tmptarget != nil
		@targetcaselist = tmptarget.targetcases if tmptarget != nil
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
