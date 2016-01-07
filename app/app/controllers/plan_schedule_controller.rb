class PlanScheduleController < ApplicationController
	def index
		@username = 'Fred'
	end

	private
	def prioritizePlan(plan, depth)
		# do a dfs of plan, adding all classes as it gets to them.
		# Go to first requirementslist, noting you current depth
		# check if depth +1 is deeper than courses previous depth (keep the deeper of the 2)
		# for each prereq call prioritze plan with the current depth
		# 	priority will be returned. 
		# 	keep highest priority saved as priority
		# 	end
		# 	increment the number of times this class has been called (importance)
	end

	def fillSemester(plan)
		prioritizePlan(plan, 0)
		#get all courses with a priority of 0. These are the only courses that can be taken this semester (potential classes)
		#if the total credits of P0 courses is greater than the amount of courses which can be taken this semester
		#then sort by importance
		potentialClassses.sort! {|a, b| b.importance <=> a.importance} #highest importance comes first
		# for all courses in list add course add course to student schedule if it can fit
		#return studentSchedule? maybe?
	end
end
