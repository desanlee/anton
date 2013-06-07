class DevicetypesController < ApplicationController

  def edit
    @devicetype = Devicetype.find(params[:id])
	render :layout => "justapage"
  end
  
  def update
    @devicetype = Devicetype.find(params[:id])
    if @devicetype.update_attributes(params[:devicetype])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
  def destroy
    @devicecate = Devicetype.find(params[:id])
	@devicecate.destroy
	redirect_to :devices
  end
  
end
