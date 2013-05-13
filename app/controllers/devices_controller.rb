class DevicesController < ApplicationController
  def catelist
    ['Hardware','Firmware','Software']
  end
  
  def new
  end
  
  def index
	if @selectcate == nil then @selectcate = self.catelist.first end
	@typelist = Devicetype.find_all_by_devicecate(@selectcate)
	if @selecttype == nil then @selecttype = @typelist.first.id if @typelist.first != nil end

    @catelist = self.catelist 
	@devicelist = Device.find_all_by_devicetype_id_and_user_id(@selecttype, current_user.id)
  end

  def selectcate
	@selectcate = params[:selectcate] 
	self.index
	render 'devices/index'
  end
  
  def selecttype
	@selecttype = params[:selecttype]
	@selectcate = params[:devicecate] 
	self.index
	render 'devices/index'
  end
  
  def addtype
    @selecttype = params[:devicetype]
	@selectcate = params[:devicecate] 
    
	@devicetype = Devicetype.new
	@devicetype.name = params[:name]
	@devicetype.note = params[:note]
	@devicetype.devicecate = @selectcate
	@devicetype.save

	self.index
	render 'devices/index'
  end
  
  def adddevice
    @selecttype = params[:devicetype]
	@selectcate = params[:devicecate] 
	
	@device = Device.new
	@device.devicetype_id = @selecttype
	@device.user_id = current_user.id
	@device.name  = params[:name]
	@device.countnum  = params[:count]
	@device.model  = params[:model]
	@device.pn  = params[:pn]
	@device.note  = params[:note]
	@device.save
	
	self.index
	render 'devices/index'
  end
  
  def destroy
    @device = Device.find(params[:id])
	@device.destroy
	redirect_to :devices
  end
  
end
