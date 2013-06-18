class CaseweightsController < ApplicationController

  def edit
    @caseweight = Caseweight.find(params[:id])
	render :layout => "justapage"
  end
  
  def update
    @caseweight = Caseweight.find(params[:id])
    if @caseweight.update_attributes(params[:caseweight])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
  def destroy
    caseweight = Caseweight.find(params[:id])
	caseweight.destroy
	redirect_to :testcases
  end
end
