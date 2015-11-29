class Student < ActiveRecord::Base
  has_many :classes
  has_many :plans
end
