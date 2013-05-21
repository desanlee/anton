class TasksController < ApplicationController
  def paralist
    ['all','any','whole']
  end
  
  def index
	@tasklist = Task.all
	@systems = System.all
	@testcases = Testcase.all
	
	if @selecttask != nil then
		@task = Task.find_by_id(@selecttask)
		@devicetypes = Devicetype.all
		@devices = @task.system.devices if @task.system != nil
		@taskobjects = @task.taskobjects
		@targetlist = @task.targets if @task != nil
	end
	
	if @selecttarget != nil then
		@target = Target.find_by_id(@selecttarget)
		@targetenvlist = @target.targetenvs if @target != nil
	end

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
					@totalcases = @totalcases + 1
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
  
  def addtdev
	render 'tasks/index'	
  end
  
  def destroy
    @task = Task.find(params[:id])
	@task.destroy
	redirect_to :tasks
  end
  
end
