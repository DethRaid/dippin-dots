class Course < ActiveRecord::Base
  fuzzily_searchable :description
end
