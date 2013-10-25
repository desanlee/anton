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
	@weightlist = Caseweight.all
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
	@weightlist = Caseweight.all
	@testcases = Testcase.find_all_by_casetype_id(@selecttype)
	
	@devicetypes = Devicetype.find_all_by_devicecate("Software") + Devicetype.find_all_by_devicecate("Firmware")
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
  
  def addlabel    
	caseweight = Caseweight.new
	caseweight.name = params[:name]
	caseweight.labelindex = params[:labelindex].to_i
	caseweight.weight = params[:weight].to_i
	caseweight.user_id = current_user.id
	caseweight.note = params[:note]
	caseweight.save

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
	@testcases = Testcase.all
	@testcases = @testcases.sort_by{ |d| d.casecode } if @testcases != nil
	
	render :layout => "justapage"
  end
   
  def destroy
    @testcase = Testcase.find(params[:id])
	@testcase.destroy
	redirect_to :testcases
  end
  
end
