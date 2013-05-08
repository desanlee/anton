class PriviledgesController < ApplicationController
  def index
	@charactors = ["manager","lead","engineer","visitor"]
	if @selectuser == nil then @selectuser = User.first.id if User.first != nil end

    @users = User.all
	@priviledges = User.find_by_id(@selectuser).priviledges
  end

  def selectuser
	@selectuser = params[:selectuser] 
	
	self.index
	render 'priviledges/index'
  end
  
  def addcharactor
  	@selectuser = params[:selectuser] 
    
	@priviledge = Priviledge.new
	@priviledge.user_id = @selectuser
	@priviledge.charactor = params[:selectcharactor] 
	@priviledge.save

	self.index
	render 'priviledges/index'
  end
  
  def destroy
    @priviledge = Priviledge.find(params[:id])
	@priviledge.destroy
	redirect_to :priviledges
  end
  
end
