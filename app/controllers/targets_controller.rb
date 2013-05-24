class TargetsController < ApplicationController

  def edit
    @target = Target.find(params[:id])
	render :layout => "justapage"
  end

  def update
    @target = Target.find(params[:id])
    if @target.update_attributes(params[:target])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
end
