# This file should contain all the record creation needed to seed the database with
# its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with 
# :setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create initial test data
# TODO: hook into the data loaders and load real data

puts 'Deleting old records'
Course.delete_all

puts 'Adding new records'
Course.create([
  {
    course_id: 'SWEN-261',
    title: 'Intro to Software Engineering',
    description: 'The worst',
    num_credits: 3
  },
  {
    course_id: 'CSCI-240',
    title: 'Introduction to Computer Science Theory',
    description: 'CS Theory',
    num_credits: 3
  },
  {
    course_id: 'SWEN-262',
    title: 'Engineering of Software Subsystems',
    description: 'Refactoring',
    num_credits: 3
  },
  {
    course_id: 'MLAS-301',
    title: 'Intermediate ASL 1',
    description: 'Intermediate ASL 1',
    num_credits: 3
  },
  {
    course_id: 'CSMP-250',
    title: 'Introduction to Computer Engineering for CEs',
    description: 'Assembly',
    num_credits: 4
  },
  {
    course_id: 'CMPE-240',
    title: 'Introduction to Computer Engineering for Non-majors',
    description: 'Assembler',
    num_credits: 4
  }
  ])

puts 'Deleting old semesters'
Semester.delete_all

puts 'Creating new semesters'
Semester.create([
  {name: 'SPRING'},
  {name: 'FALL'},
  {name: 'SUMMER'}
  ])

puts 'Deleting old requirement lists'
RequirementList.delete_all

puts 'Adding new requirement lists'
RequirementList.create([
  {
    name: 'Software Engineering',
    abbreviation: 'SWEN'
  },
  {
    name: 'Computer Engineering',
    abbreviation: 'CMPE'
  }
  ])

puts 'Done!'

# TODO: Figure out a way to make this code run every time the database is updated
Course.bulk_update_fuzzy_description