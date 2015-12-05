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
courses = Course.create([
    {:title => 'SWEN-261', :description => 'The worst'},
    {:title => 'CSCI-240', :description => 'CS Theory'},
    {:title => 'SWEN-262', :description => 'Refactoring'},
    {:title => 'MLAS-301', :description => 'Intermediate ASL 1'},
    {:title => 'CSMP-250', :description => 'Assembly'},
    {:title => 'CMPE-240', :description => 'Assembler'}
    ])

# TODO: Figure out a way to make this code run every time the database is updated
Course.bulk_update_fuzzy_description