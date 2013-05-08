class TestcasesController < ApplicationController
  def catelist
    ['Info Check','Operation','Stress']
  end
  
  def index
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
	self.index
	render 'testcases/index'
  end
  
  def selecttype
	@selecttype = params[:selecttype]
	@selectcate = params[:casecate] 
	self.index
	render 'testcases/index'
  end
  
  def addtype
    @selecttype = params[:casetype]
	@selectcate = params[:casecate] 
    
	@casetype = Casetype.new
	@casetype.name = params[:name]
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
	@testcase.steps  = params[:steps]
	@testcase.devicetype_id  = params[:devicetype]
	@testcase.save
	
	self.index
	render 'testcases/index'
  end
  
  def destroy
    @testcase = Testcase.find(params[:id])
	@testcase.destroy
	redirect_to :testcases
  end
  
end
