class AchivementsController < ApplicationController

	def selectweek
		@selectedweek = params[:selectedweek]
		session[:selectedweek] = @selectedweek
		
		self.index
		render 'achivements/index'
	end
	
	def userexecution(user)

		@currentweek = session[:selectedweek]

		userexecutions = Array.new
		user.executions.each do |e|
			userexecutions << e if e.created_at.strftime("%W") == @currentweek
		end
		resultarray = Array.new

		if userexecutions != nil then
			userexecutions.each do |me|
				secondtmp = Hash.new
				secondtmp[:title] = me.testcase.name + " on server: " + me.sysconfig.sut.name if me.sysconfig != nil
				secondtmp[:os] = "None OS related Test Cases"
				secondtmp[:bios] = ""
				secondtmp[:biosmode] = ""
				me.realconfig.each do |rd|
					secondtmp[:os] = rd.name if rd.devicetype.name == "OS"
					secondtmp[:bios] = rd.name if rd.devicetype.name == "SP_BIOS"
					secondtmp[:biosmode] = rd.name if rd.devicetype.name == "BIOS Mode Setting"
				end
				resultarray << secondtmp
			end
			resultarray = resultarray.sort_by{|e| e[:os]}
		end
		
		return resultarray
	end

	def leadachieve(user)

		@currentweek = session[:selectedweek]
		
		createdprojects = Array.new
		createdtasks = Array.new
		createddevices = Array.new
		
		user.tasks.each do |t|
			createdprojects << t if t.created_at.strftime("%W") == @currentweek
		end
		user.targets.each do |t|
			createdtasks << t if t.created_at.strftime("%W") == @currentweek
		end
		user.devices.each do |d|
			createddevices << d if d.created_at.strftime("%W") == @currentweek
		end
		leadachieves = Hash.new
		leadachieves[:projects] = createdprojects.uniq
		leadachieves[:tasks] = createdtasks.uniq
		leadachieves[:devices] = createddevices.uniq
		return leadachieves
	end
	
	def index
		@users = User.all
		@tmpweek = Time.now
		weekindex = 16
		@weeklist = Array.new
		while weekindex > 0 do
			@weeklist << @tmpweek
			@tmpweek = @tmpweek - 7.days
			weekindex = weekindex - 1
		end
		
		@currentweek = session[:selectedweek]
		@currentweek = Time.now.strftime("%W") if @currentweek == nil
		
		@mysysconfigurations = Array.new
		current_user.sysconfigs.each do |c|
			@mysysconfigurations << c if c.created_at.strftime("%W") == @currentweek
		end
			
		@userexecution = userexecution current_user
		
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
