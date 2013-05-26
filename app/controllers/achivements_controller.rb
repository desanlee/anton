class AchivementsController < ApplicationController

	def index
	  
		if !@lastweek
			@currentweek = (Time.now).strftime("%W")
			@currentweekbegin = (Time.now).at_beginning_of_week.strftime("%m.%d")
			@currentweekend = ((Time.now).at_beginning_of_week + 4.day).strftime("%m.%d")
		end
		
		@targets = current_user.targets
		
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
		
		if @targets != nil then
			if @myexecutions != nil then
				@resultarray = Array.new
				@firstlevel = Hash.new
				@secondtmp = Hash.new
				@secondlevel = Array.new
				
				@targets.each do |target| 
					@firstlevel[:title] = target.name
					@firstlevel[:title] = target.task.name + " - " + @firstlevel[:title] if target.task != nil
					if target.env != nil then 
						@myexecutions.each do |me|
							if target.env.testcases.include? me.testcase and !(target.env.devices & me.realconfig).empty? then
								@secondtmp[:title] = me.testcase.name
								@secondtmp[:title] = @secondtmp[:title] + " on server: " + me.sysconfig.sut.name if me.sysconfig != nil
								@secondtmp[:os] = "None OS related Test Cases"
								me.realconfig.each do |rd|
									@secondtmp[:os] = "On " + rd.name if rd.devicetype.name == "OS"
								end
								@secondlevel << @secondtmp
							end
						end
						@firstlevel[:secondlevel] = @secondlevel.sort_by{|e| e[:os]}
						@resultarray << @firstlevel
					end
				end 
			end
		end
	end
	
	def lastweek
		@lastweek = true
		@currentweek = (Time.now - 7.days).strftime("%W")
		@currentweekbegin = (Time.now - 7.days).at_beginning_of_week.strftime("%m.%d")
		@currentweekend = ((Time.now - 7.days).at_beginning_of_week + 4.day).strftime("%m.%d")
		
		self.index
		render 'achivements/index'
	end
	
	def thisweek
		@lastweek = false
		self.index
		render 'achivements/index'
	end
	
end
