class SysconfigrelationshipsController < ApplicationController

  def destroy
    @sysconfigrelationship = Sysconfigrelationship.find(params[:id])
	@sysconfigrelationship.destroy
	redirect_to :sysconfigs
  end
  
end
