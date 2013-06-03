class AchivementsController < ApplicationController

	def userexecution(user)
		if !@lastweek
			@currentweek = (Time.now).strftime("%W")
			@currentweekbegin = (Time.now).at_beginning_of_week.strftime("%m.%d")
			@currentweekend = ((Time.now).at_beginning_of_week + 4.day).strftime("%m.%d")
		end
		
		usertargets = user.targets
		userexecutions = Array.new
		user.executions.each do |e|
			userexecutions << e if e.created_at.strftime("%W") == @currentweek
		end
		resultarray = Array.new
		usedarray = Array.new
		leftarray = Array.new
		if usertargets != nil then
			if userexecutions != nil then
				usertargets.each do |target| 
					firstlevel = Hash.new
					secondlevel = Array.new
					firstlevel[:title] = target.name
					firstlevel[:title] = target.task.name + " - " + firstlevel[:title] if target.task != nil
					if target.env != nil then 
						userexecutions.each do |me|
							secondtmp = Hash.new
							if target.env.testcases.include? me.testcase and !(target.env.devices & me.realconfig).empty? then
								secondtmp[:title] = me.testcase.name
								secondtmp[:title] = secondtmp[:title] + " on server: " + me.sysconfig.sut.name if me.sysconfig != nil
								secondtmp[:os] = "None OS related Test Cases"
								me.realconfig.each do |rd|
									secondtmp[:os] = "On " + rd.name if rd.devicetype.name == "OS"
								end
								secondlevel << secondtmp
								usedarray << me
							end
						end
						firstlevel[:secondlevel] = secondlevel.sort_by{|e| e[:os]}
						resultarray << firstlevel
					end
				end 
				userexecutions.each do |me|
					if !usedarray.include? me then
						leftarray << me
					end
				end
			end
		end
		rtnexecutions = Hash.new
		rtnexecutions[:resultarray] = resultarray
		rtnexecutions[:leftarray] = leftarray.uniq
		return rtnexecutions
	end
	
	def index
		@users = User.all
		
		if current_user.engineer? then
			@mysysconfigurations = Array.new
			current_user.sysconfigs.each do |c|
				@mysysconfigurations << c if c.created_at.strftime("%W") == @currentweek
			end
			
			@userexecution = userexecution current_user
		end
		
		if current_user.lead? then
			current_user.engineers.each do |euser|
				@userexecution[euser.id] = userexecution euser
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
	
	def addteammember
	teammember = Teamrelationship.new
	teammember.lead_id = current_user.id
	teammember.engineer_id = params[:member]
	teammember.save
	
	self.index
	render 'achivements/index'
	end
	
end
