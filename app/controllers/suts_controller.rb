class SutsController < ApplicationController

  def edit
    @sut = Sut.find(params[:id])
	render :layout => "justapage"
  end
  
  def update
    @sut = Sut.find(params[:id])
    if @sut.update_attributes(params[:sut])
       render :text => '<script type="text/javascript"> window.close() </script>'
    else
      render 'edit'
    end
  end
  
  def destroy
    @sut = Sut.find(params[:id])
	@sut.destroy
	redirect_to :sysconfigs
  end
  
end
