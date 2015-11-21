require 'rubygems'
require_relative 'Course'

def make_course( text )
	puts "Making course from " +text +"\n"
	lines = text.split( /\n/ )
	course_id = lines[0]
	course_name = lines[1]
	course_desc = lines[2..-1].join( "\n" ).gsub "\n", ' '

	if lines[-1] =~ /\(([A-Za-z, ]*)\)/
		semesteres_offered = lines[-1][/\(([A-Za-z, ]*)\)/][1..-2]
	end

	Course.new( course_id, course_name, course_desc, nil, nil, nil, semesteres_offered )
end

def main
	name1 = ARGV[0]
	name2 = ARGV[1]
	puts "Diffing files " +name1 +" and " +name2
	
	file_1_courses = gen_course_list_from_file name1
	file_2_courses = gen_course_list_from_file name2
end

def gen_course_list_from_file( filename )
	courses = Array.new
	File.open( "../../data/txt/2015_Undergrad_Course_Descriptions.txt" ) do |f|
		course_accum = ""
		parsing_class = false
		f.each_line do |line|
			# if the line has four capital letters followed by a dash and three numbers, we're starting a new course description
			if line =~ /^[A-Z]{4}-[0-9]{3}/ and line.length < 15

				courses << (make_course course_accum) if course_accum.length > 1
				course_accum = ""
				parsing_class = true
			
			elsif line.length < 2
				# If we find an empty line, stop parsing classes
				parsing_class = false

			end
			course_accum += line if parsing_class

		end
		courses << (make_course course_accum)
	end
	courses
end

main