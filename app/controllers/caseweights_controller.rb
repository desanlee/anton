class CaseweightsController < ApplicationController
  def destroy
    caseweight = Caseweight.find(params[:id])
	caseweight.destroy
	redirect_to :testcases
  end
end
