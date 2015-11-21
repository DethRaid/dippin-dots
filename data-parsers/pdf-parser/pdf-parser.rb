require 'rubygems'
require_relative 'Course'

def make_course( text )
	lines = text.split( /\n/ )
	course_id = lines[0]
	course_name = lines[1]
	course_desc = lines[2..-1].join( "\n" ).gsub "\n", ' '
	semesteres_offered = lines[-1][/\(([A-Za-z, ]*)\)/][1..-2]

	puts "\n"
	puts "course_id: " +course_id
	puts "course_name: " +course_name
	puts "course_desc: " +course_desc
	puts "semesteres_offered: " +semesteres_offered

	Course.new( course_id, course_name, course_desc, nil, nil, nil, semesteres_offered )
end

def main
	courses = Array.new
	# Read in one PDF file
	File.open( "../../data/txt/basic_course.txt" ) do |f|
		course_accum = ""
		should_end = 0
		f.each_line do |line|
			puts "course number " +should_end.to_s
			# if the line has four capital letters followed by a dash and three numbers, we're starting a new course description
			if line =~ /^[A-Z]{4}-[0-9]{3}$/

				courses << (make_course course_accum)
				course_accum = ""

				return if should_end == 3
				
				should_end += 1
			end
			course_accum += line

		end
		courses << (make_course course_accum)
	end
	puts courses[0].to_str
end

main