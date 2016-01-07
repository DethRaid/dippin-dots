class Course < ActiveRecord::Base
  belongs_to :student
  has_many :prepreqs, class_name: 'Course'
  has_many :coreqs, class_name: 'Course'
  has_many :semesters
  fuzzily_searchable :description

  def to_s
    "course_id: #{course_id} title: #{title} num_credits: #{num_credits}"
  end
end
