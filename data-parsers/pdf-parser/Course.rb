class Course
	attr_reader :id
	attr_reader :name
	attr_reader :description
	attr_reader :credits
	attr_reader :prereqs
	attr_reader :coreqs
	attr_reader :semesteres_offered

	def initialize( id, name, description, credits, prereqs, coreqs, semesteres_offered )
		@id = id
		@name = name
		@description = description
		@num_credits = credits
		@prereqs = Array.new
		@semesteres_offered = semesteres_offered
	end

	def to_str
		"\nid: " +@id.to_s +
		"\nname: " +@name.to_s +
		"\ndescription: " +@description.to_s +
		"\nnum_credits: " +@num_credits.to_s +
		"\nprereqs: " +@prereqs.to_s +
		"\nsemesteres_offered: " +@semesteres_offered.to_s +
		"\n"
	end
end