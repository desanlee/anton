class TargetdeprelationshipsController < ApplicationController

  def destroy
    @targetdeprelationship = Targetdeprelationship.find(params[:id])
	@targetdeprelationship.destroy
	redirect_to :tasks
  end
  
end
