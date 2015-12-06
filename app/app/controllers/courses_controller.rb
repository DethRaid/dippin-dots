class CoursesController < ApplicationController
  def show
    course_id = params[:id]

    @course = Course.find_by id: course_id
  end
end
