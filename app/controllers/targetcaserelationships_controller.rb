class TargetcaserelationshipsController < ApplicationController

  def destroy
    @targetcaserelationship = Targetcaserelationship.find(params[:id])
	@targetcaserelationship.destroy
	redirect_to :tasks
  end
  
end
