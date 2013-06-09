class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		
		@executions = @user.executions
		@executioncount = 0
		@infocheckcount = 0
		@operationcount = 0
		@stresscount = 0
		
		@executions.each do |e|
			@executioncount += 1
			@infocheckcount += 1 if e.testcase.casecate == "Info Check" if e.testcase != nil
			@operationcount += 1 if e.testcase.casecate == "Operation" if e.testcase != nil
			@stresscount += 1 if e.testcase.casecate == "Stress" if e.testcase != nil
		end
		
		@testcases = @user.testcases
		@testcasecount = 0
		@executedcount = 0
		@infocheckcasecount = 0
		@operationcasecount = 0
		@stresscasecount = 0
		
		@testcases.each do |e|
			@testcasecount += 1
			@executedcount += e.executions.count
			@infocheckcasecount += 1 if e.casecate == "Info Check" if e != nil
			@operationcasecount += 1 if e.casecate == "Operation" if e != nil
			@stresscasecount += 1 if e.casecate == "Stress" if e != nil
		end
		
		@sysconfigcount = @user.sysconfigs.count
		
		render :layout => "justapage"
	end
	
end
