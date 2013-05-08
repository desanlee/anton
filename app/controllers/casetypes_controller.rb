class CasetypesController < ApplicationController
  def destroy
    @casecate = Casetype.find(params[:id])
	@casecate.destroy
	redirect_to :testcases
  end
end
