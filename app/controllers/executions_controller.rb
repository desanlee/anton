class ExecutionsController < ApplicationController
  
  def index
	@sutlist = Sut.find_all_by_holder_id(current_user.id)
	if @sutlist != nil then
		if @selectsut == nil then @selectsut = @sutlist.first.id if @sutlist.first != nil end
	end
	
	@casetypes = Casetype.all
	if @selecttype == nil then @selecttype = Casetype.first.id if Casetype.first != nil end
	if @selecttype != nil then
		if @selectcase == nil then @selectcase = Testcase.find_all_by_casetype_id(@selecttype).first.id end
	end
	
	@testcases = Testcase.find_all_by_casetype_id(@selecttype)
	if @selectcase != nil then
		@testcase = Testcase.find_by_id(@selectcase)
	end
	
	if @selectsut != nil then
		@sut = Sut.find_by_id(@selectsut)
		@sysconfigs = Sut.find_by_id(@selectsut).sysconfigs
		@sysconfig = @sysconfigs.last if @sysconfigs != nil
		if @testcase != nil then
			@envdevices =  @sut.system.devices.select{ |d| d.devicetype_id == @testcase.devicetype_id }
		end
	end
	@executions = @sysconfig.executions if @sysconfig != nil

  end

  def selectsut
	@selectsut = params[:selectsut] 
	@selectcate = params[:selectcate] 
	@selecttype = params[:selecttype] 
	
	self.index
	render 'executions/index'
  end
  
  def selecttype
	@selectsut = params[:selectsut] 
	@selecttype = params[:selecttype] 
	
	self.index
	render 'executions/index'
  end
  
  def selectcase
	@selectsut = params[:selectsut] 
	@selecttype = params[:selecttype]   
	@selectcase = params[:selectcase]
	
	self.index
	render 'executions/index'
  end
  
  
  def addcase
  	@selectsut = params[:selectsut] 
	@selecttype = params[:selecttype] 
    @sysconfig = Sut.find_by_id(@selectsut).sysconfigs.last
	
	@execution = Execution.new
	@execution.user_id = current_user.id
	@execution.sysconfig_id = @sysconfig.id
	@execution.testcase_id = params[:selectcase] 
	@execution.result = params[:testresult]
	@execution.bug = params[:moreresult] 
	@execution.note = params[:note] 
	@execution.device_id = params[:selectenvdevice]

	if params[:selectenvdevice] != nil then
		@sysconfig = Sut.find_by_id(@selectsut).sysconfigs.last
		@newrelation = Sysconfigrelationship.new
		@newrelation.sysconfig_id = @sysconfig.id
		@newrelation.device_id = params[:selectenvdevice]
		@newrelation.user_id = current_user.id
		@newrelation.save
		@execution.sysconfigrelationship_id = @newrelation.id
	end
	
	@execution.save
	
	self.index
	render 'executions/index'
  end
  
  def destroy
    @execution = Execution.find(params[:id])
	@sysconfigrelationship = Sysconfigrelationship.find_by_id(@execution.sysconfigrelationship_id)
	@sysconfigrelationship.destroy if @sysconfigrelationship != nil
	@execution.destroy
	redirect_to :executions
  end
  
end


