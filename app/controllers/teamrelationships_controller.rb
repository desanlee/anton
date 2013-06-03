class TeamrelationshipsController < ApplicationController

  def destroy
    @teamrelationship = Teamrelationship.find(params[:id])
	@teamrelationship.destroy
	redirect_to :achivements
  end
  
end
