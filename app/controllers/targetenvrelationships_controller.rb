class TargetenvrelationshipsController < ApplicationController

  def destroy
    @targetenvrelationship = Targetenvrelationship.find(params[:id])
	@targetenvrelationship.destroy
	redirect_to :tasks
  end
  
end
