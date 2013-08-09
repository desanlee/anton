class SysconfigsController < ApplicationController

  def edit
    @sysconfig = Sysconfig.find(params[:id])
	@selectsut = session[:selectsut]
	@sut = Sut.find_by_id(@selectsut)
	@devices = @sut.system.devices
	
	render :layout => "justapage"
  end
  
  def index
	
	@selecttype = session[:selecttype]
	@selectsut = session[:selectsut]
	
	@systems = System.all
	@users = User.all
	@devicetypes = Devicetype.find_all_by_devicecate("Hardware")
	if @selecttype == nil then @selecttype = @devicetypes.first.id if @devicetypes.first != nil end
	
	if current_user.lead? then 
		@sutlist = Sut.find_all_by_user_id(current_user.id)
	elsif current_user.engineer? then
		@sutlist = Sut.find_all_by_holder_id(current_user.id)
	end
	
	@sutlist = @sutlist.sort{|s| s.system} if @sutlist != nil
	
	if @selectsut == nil then 
		if @sutlist != nil then
			@sut = @sutlist.first if @sutlist.first != nil
			@selectsut = @sutlist.first.id if @sutlist.first != nil
		end
	end 
	
	if @selectsut != nil then 
		@sysconfiglist = Sysconfig.find_all_by_sut_id(@selectsut)
		@sut = Sut.find_by_id(@selectsut)
		@devices = @sut.system.devices.select{ |d| d.devicetype_id == @selecttype.to_i }
		@devices = @devices.sort{|a| a.created_at.to_date} if @devices != nil
	
		if @sysconfiglist.last != nil then 
			@currentsysconfig = @sysconfiglist.last 
		else 
			@currentsysconfig = Sysconfig.new 
			@currentsysconfig.sut_id = @selectsut
			@currentsysconfig.user_id = current_user.id
			@currentsysconfig.save
			@sysconfiglist << @currentsysconfig
		end
		
		@devicelist = @currentsysconfig.devices.sort_by! { |obj| obj.devicetype_id }
	else
		@currentsysconfig = Sysconfig.new 
	end
	
  end

  def selectsut
	@selectsut = params[:selectsut] 
	
	session[:selectsut] = params[:selectsut]
	
	self.index
	render 'sysconfigs/index'
  end
  
  def selectuser
	@selectsut = params[:selectsut] 
	@transfersut = Sut.find_by_id(@selectsut)
	@transfersut.update_attributes(:holder_id => params[:selectuser])
	tmpconfig = @transfersut.sysconfigs.last
	tmpconfig.update_attributes(:user_id => params[:selectuser])

	self.index
	render 'sysconfigs/index'
  end
  
  def selecttype
	@selectsut = params[:selectsut] 
	@selecttype = params[:selecttype]
	
	session[:selecttype] = params[:selecttype]
	
	self.index
	render 'sysconfigs/index'
  end
  
  def addsut
	@selectsut = params[:devicecate] 
    
	@sut = Sut.new
	@sut.name = params[:name]
	@sut.system_id = params[:system]
	@sut.user_id = current_user.id
	@sut.holder_id = current_user.id
	@sut.spip = params[:spip]
	@sut.note = params[:note]
	@sut.save

	self.index
	render 'sysconfigs/index'
  end
  
  def adddevice
    @selecttype = params[:selecttype]
	@selectsut = params[:selectsut] 
	@currentsysconfig_id = params[:currentsysconfig_id] 
	
	positionlist = params[:deviceposition]
	if positionlist != "" then
		positionlist.split(',').each do |p|
			@sysconfigrelationship = Sysconfigrelationship.new
			@sysconfigrelationship.sysconfig_id = @currentsysconfig_id
			@sysconfigrelationship.device_id = params[:selectdevice]
			@sysconfigrelationship.position = p
			@sysconfigrelationship.save
		end
	else
		@sysconfigrelationship = Sysconfigrelationship.new
		@sysconfigrelationship.sysconfig_id = @currentsysconfig_id
		@sysconfigrelationship.device_id = params[:selectdevice]
		@sysconfigrelationship.save
	end
	
	self.index
	render 'sysconfigs/index'
  end
  
  def newconfig
    @selecttype = params[:selecttype]
	@selectsut = params[:selectsut] 
	@currentsysconfig_id = params[:currentsysconfig_id] 
	@newconfig = Sysconfig.new
	@newconfig.sut_id = @selectsut
	@newconfig.user_id = current_user.id
	@newconfig.save
	
	allrelationships = Sysconfigrelationship.find_all_by_sysconfig_id(@currentsysconfig_id)
	hwrelationships = allrelationships.select {|r| r.device.devicetype.devicecate == "Hardware"}
	if hwrelationships != nil then 
		hwrelationships.each do |r|
			@newrelation = Sysconfigrelationship.new
			@newrelation.sysconfig_id = @newconfig.id
			@newrelation.device_id = r.device_id
			@newrelation.position = r.position
			@newrelation.user_id = current_user.id
			@newrelation.save
		end
	end
	swrelationships = allrelationships.select {|r| r.device.devicetype.devicecate != "Hardware"}
	if swrelationships != nil then 
		tmprelation = nil
		swrelationships.sort_by {|r| r.device.devicetype_id}.reverse.each do |sr|
			if tmprelation != nil then
				if tmprelation.device.devicetype_id != sr.device.devicetype_id then
					@newrelation = Sysconfigrelationship.new
					@newrelation.sysconfig_id = @newconfig.id
					@newrelation.device_id = sr.device_id
					@newrelation.user_id = current_user.id
					@newrelation.save
					tmprelation = sr
				end
			else
				@newrelation = Sysconfigrelationship.new
				@newrelation.sysconfig_id = @newconfig.id
				@newrelation.device_id = sr.device_id
				@newrelation.user_id = current_user.id
				@newrelation.save
				tmprelation = sr
			end 
		end
	end
	
	self.index
	render 'sysconfigs/index'
  end
  
  def destroy
    @sysconfig = Sysconfig.find(params[:id])
	@sysconfig.destroy
	redirect_to :sysconfigs
  end
  
end

