class AchivementsController < ApplicationController

  def index
  
	if current_user.engineer? then
		@mysysconfigurations = current_user.sysconfigs
		@myexecutions = current_user.executions
		@mytestcases = current_user.testcases
		@mybugs = @myexecutions.find_all_by_result('fail') if @myexecutions != nil
	end
	
  end
  
end
