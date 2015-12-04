class Course < ActiveRecord::Base
  belongs_to :student
  fuzzily_searchable :description
end
