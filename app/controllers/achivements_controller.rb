class AchivementsController < ApplicationController

  def index
  
	@currentweek = (Time.now).strftime("%W")
	@currentweekbegin = (Time.now).at_beginning_of_week.strftime("%m.%d")
	@currentweekend = ((Time.now).at_beginning_of_week + 4.day).strftime("%m.%d")
	if current_user.engineer? then
		@mysysconfigurations = Array.new
		current_user.sysconfigs.each do |c|
			@mysysconfigurations << c if c.created_at.strftime("%W") == @currentweek
		end
		
		@myexecutions = Array.new
		current_user.executions.each do |e|
			@myexecutions << e if e.created_at.strftime("%W") == @currentweek
		end
		
		
	end
	
  end
  
end
