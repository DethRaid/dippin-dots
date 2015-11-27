require 'rubygems'
require_relative 'Course'
require_relative 'Change'

def make_course(text)
  lines = text.split(/\n/)
  course_id = lines[0][0...8]
  course_name = lines[1]
  course_desc = lines[2..-1].join("\n").tr("\n", ' ') unless lines[2..-1].nil?

  semester_regex = /\(([A-Za-z, ]*)\)/
  if lines[-1] =~ semester_regex
    semester_line = lines[-1, 2].join
    semesters_offered = semester_line[semester_regex][1..-2]
  end

  unless semesters_offered.is_a?(Array) || semesters_offered.nil?
    semester_names = ["Fall", "Summer", "Spring", "Intercession", "F", "S", "Su", "W"]

    semesters_offered = semesters_offered.split
    semesters_offered = semesters_offered.map { |str| str.chomp(',') }
    semesters_offered = semesters_offered.select { |str| semester_names.include? str }
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

  puts "#{file_1_courses.length} courses offered last year, #{file_2_courses.length} courses offered this year"

  print_diff_stats(changes)

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
  course_list.map do |course|
    Change.new(course.id, [], [], dropped, !dropped)
  end
end

def get_changed_semesters(semester_list_1, semester_list_2)
  semester_list_1.reduce([]) do |a, e|
    should_add = true

    semester_list_2.each do |e2|
      should_add = false if e[0] == e2[0]
    end

    should_add ? a << e : a
  end
end

def find_diffs_for_course(course1, course2)
  course1_no_semesters = course1.semesters_offered.nil?
  course2_no_semesters = course2.semesters_offered.nil?

  if course1_no_semesters
    Change.new(course2.id, [], course2.semesters_offered)

  elsif course2_no_semesters
    Change.new(course2.id, course1.semesters_offered, [])

  else
    semesters_dropped = get_changed_semesters(course1.semesters_offered, course2.semesters_offered)
    semesters_added = get_changed_semesters(course2.semesters_offered, course1.semesters_offered)

    Change.new(course2.id, semesters_dropped, semesters_added) unless semesters_dropped.empty? && semesters_added.empty?
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
  diffs.flatten.compact.select { |diff| !diff.semesters_lost.nil? || !diff.semesters_gained.nil? }
end

def print_diff_stats(diffs)
  num_lost_a_semester = diffs.reduce(0) do |a, e|
    unless e.semesters_lost.nil? || e.semesters_lost.empty?
      a += 1 
    else
      a
    end
  end

  puts "#{num_lost_a_semester} classes lost at least one semester"

  num_gained_a_semester = diffs.reduce(0) do |a, e|
    unless e.semesters_gained.nil? || e.semesters_gained.empty?
      a += 1
    else
      a
    end
  end

  puts "#{num_gained_a_semester} classes gained at least one semester"

  num_new = diffs.reduce(0) do |a, e|
    if e.new
      a += 1
    else
      a
    end
  end

  puts "#{num_new} classes are new this year"

  num_dropped = diffs.reduce(0) do |a, e|
    if e.dropped
      a += 1
    else
      a
    end
  end

  puts "#{num_dropped} classes are no longer available this year"

  semesters_gained_map = diffs.reduce({:summer => 0, :spring => 0, :fall => 0, :intercession => 0}) do |a, e|
    unless e.semesters_gained.nil? || e.semesters_gained.length == 0
      e.semesters_gained.each do |semester|
         if semester =~ /^S[ou]/
          a[:summer] += 1
        elsif semester =~ /^S/
          a[:spring] += 1
        elsif semester =~ /^[IW]/
          a[:intercession] += 1
        elsif semester =~ /^F/
          a[:fall] += 1
        end
      end
    end
    a
  end

  puts "#{semesters_gained_map[:fall]} courses gained a Fall offering"
  puts "#{semesters_gained_map[:spring]} courses gained a Spring offering"
  puts "#{semesters_gained_map[:summer]} courses gained a Summer offering"
  puts "#{semesters_gained_map[:intercession]} courses gained an Intercession offering"

  semesters_lost_map = diffs.reduce({:summer => 0, :spring => 0, :fall => 0, :intercession => 0}) do |a, e|
    unless e.semesters_lost.nil? || e.semesters_lost.length == 0
      e.semesters_lost.each do |semester|
        if semester =~ /^S[ou]/
          a[:summer] += 1
        elsif semester =~ /^S/
          a[:spring] += 1
        elsif semester =~ /^[IW]/
          a[:intercession] += 1
        elsif semester =~ /^F/
          a[:fall] += 1
        end
      end
    end
    a
  end

  puts "#{semesters_lost_map[:fall]} courses lost a Fall offering"
  puts "#{semesters_lost_map[:spring]} courses lost a Spring offering"
  puts "#{semesters_lost_map[:summer]} courses lost a Summer offering"
  puts "#{semesters_lost_map[:intercession]} courses lost an Intercession offering"

end

main
