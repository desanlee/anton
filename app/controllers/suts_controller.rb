class SutsController < ApplicationController

  def destroy
    @sut = Sut.find(params[:id])
	@sut.destroy
	redirect_to :sysconfigs
  end
  
end
