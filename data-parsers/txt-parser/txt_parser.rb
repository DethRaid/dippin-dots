require 'rubygems'
require_relative 'Course'
require_relative 'Change'

def make_course(text)
  lines = text.split(/\n/)
  course_id = lines[0]
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
  puts "Calculated #{changes.length} differences"
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
      if line =~ /^[A-Z]{4}-[0-9]{3}/ && line.length < 15

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

def find_diffs_in_second_list(list1, list2)
  diffs = []

  list1.each do |course1|
    course2 = list2.select { |course| course.id == course1.id }

    course2_nil = course2.nil?
    course1_has_semesters = course1.semesters_offered.nil?
    course2_has_semesters = course2.semesters_offered.nil? if course2_nil

    unless course2_nil || !course1_has_semesters || !course2_has_semesters
      course2 = course2[0]
      # We found what we want. Let's compare semesters
      semesters1 = course1.semesters_offered
      semesters2 = course2.semesters_offered

      semesters_of_course1 = semesters1 - semesters2
      semesters_of_course2 = semesters2 - semesters1

      diffs << Change.new(course1.id, semesters_of_course2, semesters_of_course1)
    end
    diffs
  end

  diffs
end

main
