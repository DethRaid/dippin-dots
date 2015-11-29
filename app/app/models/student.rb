class Student < ActiveRecord::Base
  has_many :courses
  has_many :plans
end
