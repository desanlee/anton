class AvlrelationshipsController < ApplicationController

  def destroy
    @avlrelationship = Avlrelationship.find(params[:id])
	@avlrelationship.destroy
	redirect_to :systems
  end
  
end
