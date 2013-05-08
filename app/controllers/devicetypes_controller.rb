class DevicetypesController < ApplicationController

  def destroy
    @devicecate = Devicetype.find(params[:id])
	@devicecate.destroy
	redirect_to :devices
  end
  
end
