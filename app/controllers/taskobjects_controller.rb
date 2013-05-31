class TaskobjectsController < ApplicationController

  def destroy
    @taskobject = Taskobject.find(params[:id])
	@taskobject.destroy
	redirect_to :tasks
  end
  
end
