class TargetdeprelationshipsController < ApplicationController

  def destroy
    @targetdeprelationship = Targetdeprelationship.find(params[:id])
	@targetdeprelationship.destroy
	redirect_to :tasks, :action => "index", :selecttask => params[:selecttask], :selecttarget => params[:selecttarget]
  end
  
end
