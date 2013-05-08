class SystemsController < ApplicationController
  def catelist
    ['Hardware','Firmware','Software']
  end
  
  def index
	if @selectcate == nil then @selectcate = 'Hardware' end
	if @selectsystem == nil then @selectsystem = System.first.id if System.first != nil end
	
	@devicetypes = Devicetype.find_all_by_devicecate(@selectcate)
	@selecttype = @devicetypes.first.id if @selecttype == nil
	@devices = Device.find_all_by_devicetype_id_and_user_id(@selecttype, current_user.id)
	
    @catelist = self.catelist
	@systemlist = System.all
	@devicelist = System.find_by_id(@selectsystem).devices.find_all if @selectsystem != nil
  end

  def selectcate
	@selectcate = params[:selectcate] 
	@selectsystem = params[:system] 
	self.index
	render 'systems/index'
  end
  
  def selectsystem
	@selectsystem = params[:selectsystem]
	@selectcate = params[:devicecate] 
	self.index
	render 'systems/index'
  end
  
  def selecttype
  	@selectsystem = params[:selectsystem]
	@selectcate = params[:devicecate] 
	@selecttype = params[:devicetype]
	self.index
	render 'systems/index'
  end 
  
  def addsystem
    @selectsystem = params[:selectsystem]
	@selectcate = params[:devicecate] 
    
	@system = System.new
	@system.user_id = current_user.id
	@system.name = params[:name]
	@system.model = params[:model]
	@system.pn = params[:pn]
	@system.note = params[:note]
	@system.save

	self.index
	render 'systems/index'
  end
  
  def adddevice
    @selectsystem = params[:system]
	@selectcate = params[:devicecate] 
	@selecttype = params[:devicetype]
	
	@newavlrelationship = Avlrelationship.new
	@newavlrelationship.device_id = params[:selectdevice]
	@newavlrelationship.system_id = @selectsystem
	@newavlrelationship.maxnum = params[:maxnum]
	@newavlrelationship.note = params[:note]
	
	@newavlrelationship.save
	
	self.index
	render 'systems/index'
  end
  
  def destroy
    @system = System.find(params[:id])
	@system.destroy
	redirect_to :systems
  end
  
end

