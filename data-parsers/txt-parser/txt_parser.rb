require 'rubygems'
require_relative 'Course'
require_relative 'Change'

def make_course(text)
  lines = text.split(/\n/)
  course_id = lines[0][0...8]
  course_name = lines[1]
  course_desc = lines[2..-1].join("\n").tr("\n", ' ')

  semester_regex = /\(([A-Za-z, ]*)\)/
  if lines[-1] =~ semester_regex
    semesters_offered = lines[-1][semester_regex][1..-2]
  end

  unless semesters_offered.is_a?(Array) || semesters_offered.nil?
    semesters_offered = semesters_offered.split
  end

  Course.new(course_id, course_name, course_desc, nil, nil, nil, semesters_offered) 
end

def main
  name1 = ARGV[0]
  name2 = ARGV[1]
  puts "Diffing files #{name1} and #{name2}"

  file_1_courses = gen_course_list_from_file(name1)
  file_2_courses = gen_course_list_from_file(name2)
  changes = find_diffs_in_second_list(file_1_courses, file_2_courses)
  puts "Calculated #{changes.length} differences:"
  puts changes
end

def gen_course_list_from_file(filename)
  courses = []
  File.open(filename) do |f|
    course_accum = ''
    parsing_class = false
    f.each_line do |line|
      # puts line
      # if the line has four capital letters followed by a dash and three numbers, we're starting a new course description
      if line =~ /^[A-Z0-9]{4}-[0-9]{3}/ && line.length < 15

        courses << make_course(course_accum) if course_accum.length > 0
        course_accum = ''
        parsing_class = true

      elsif line.length < 2
        # If we find an empty line, stop parsing classes
        parsing_class = false

      end
      course_accum += line if parsing_class
    end
    courses << make_course(course_accum) if course_accum.length > 0
  end
  courses
end

def courses_to_diffs(course_list, dropped)
  puts "Dealing with #{course_list.length} courses"
  course_list.map do |course|
    puts "Adding diff for course #{course.id}"
    Change.new(course.id, [], [], dropped, !dropped)
  end
end

def find_diffs_for_course(course1, course2)
  semesters_dropped = course1.semesters_offered - course2.semesters_offered
  semesters_added = course2.semesters_offered - course1.semesters_offered

  if semesters_dropped.nil? && semesters_added.nil?
    Change.new(course2.id, semesters_dropped, semesters_added)
  else
    nil
  end
end

def find_diffs_in_second_list(last_year_courses, this_year_courses)
  diffs = []
  old_courses = []
  new_courses = []

  last_year_courses.each do |course1|
    if this_year_courses.include? course1
      course2 = this_year_courses.find { |course| course == course1 }

      diffs << find_diffs_for_course(course1, course2) unless course2.nil?
    else
      old_courses << course1
    end
  end

  this_year_courses.each { |course| new_courses << course unless last_year_courses.include? course }

  diffs << courses_to_diffs(old_courses, true) unless old_courses.nil?
  diffs << courses_to_diffs(new_courses, false) unless new_courses.nil?
  diffs.flatten.compact
end

main
