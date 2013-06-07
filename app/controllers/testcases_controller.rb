class TestcasesController < ApplicationController
  def catelist
    ['Info Check','Operation','Stress']
  end

  def show
    @testcase = Testcase.find(params[:id])
	render :layout => "justapage"
  end
  
  def edit
	@catelist = self.catelist
	@typelist = Casetype.all
	@devicetypes = Devicetype.find_all_by_devicecate("Software") + Devicetype.find_all_by_devicecate("Firmware")
	
    @testcase = Testcase.find(params[:id])
	render :layout => "justapage"
  end
  
  def update
    @testcase = Testcase.find(params[:id])
    if @testcase.update_attributes(params[:testcase])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
  def index
  
	@selectcate = session[:selectcate]
	@selecttype = session[:selecttype]
	
	if @selectcate == nil then @selectcate = 'Info Check' end
	if @selecttype == nil then @selecttype = Casetype.first.id if Casetype.first != nil end
	
    @catelist = self.catelist
	@typelist = Casetype.all
	@testcases = Testcase.find_all_by_casecate_and_casetype_id(@selectcate, @selecttype)
	
	@devicetypes = Devicetype.find_all_by_devicecate("Software") + Devicetype.find_all_by_devicecate("Firmware")
  end

  def selectcate
	@selectcate = params[:selectcate] 
	@selecttype = params[:casetype] 
	
	session[:selectcate] = params[:selectcate] 
	
	self.index
	render 'testcases/index'
  end
  
  def selecttype
	@selecttype = params[:selecttype]
	@selectcate = params[:casecate] 
	
	session[:selecttype] = params[:selecttype]
	
	self.index
	render 'testcases/index'
  end
  
  def addtype
    @selecttype = params[:casetype]
	@selectcate = params[:casecate] 
    
	@casetype = Casetype.new
	@casetype.name = params[:name]
	@casetype.user_id = current_user.id
	@casetype.note = params[:note]
	@casetype.save

	self.index
	render 'testcases/index'
  end
  
  def addcase
    @selecttype = params[:casetype]
	@selectcate = params[:casecate] 
	
	@testcase = Testcase.new
	@testcase.casetype_id = @selecttype
	@testcase.casecate = @selectcate
	@testcase.name  = params[:name]
	@testcase.user_id = current_user.id
	@testcase.steps  = params[:steps]
	@testcase.devicetype_id  = params[:devicetype]
	@testcase.save
	
	self.index
	render 'testcases/index'
  end

  def twiki
	@infochecktestcases = Testcase.find_all_by_casecate("Info Check")
	@infochecktestcases = @infochecktestcases.select {|d| d.casetype != nil}
	@infochecktestcases = @infochecktestcases.sort_by{ |d| d.casetype } if @infochecktestcases != nil
	
	@operationtestcases = Testcase.find_all_by_casecate("Operation")
	@operationtestcases = @operationtestcases.select {|d| d.casetype != nil}
	@operationtestcases = @operationtestcases.sort_by{ |d| d.casetype } if @operationtestcases != nil
	
	@stresstestcases = Testcase.find_all_by_casecate("Stress")
	@stresstestcases = @stresstestcases.select {|d| d.casetype != nil}
	@stresstestcases = @stresstestcases.sort_by{ |d| d.casetype } if @stresstestcases != nil
	
	render :layout => "justapage"
  end
   
  def destroy
    @testcase = Testcase.find(params[:id])
	@testcase.destroy
	redirect_to :testcases
  end
  
end
