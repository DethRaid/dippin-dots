class Student::AddCoursesController < ApplicationController
  def create
    puts "called for params #{params}"
    course_id = params[:id]
    new_course = Course.find_by(title: course_id)

    puts "selected #{new_course}"

    if session.has_key? :courses
      session[:courses] += [new_course]
    else
      session[:courses] = [new_course]
    end

    puts "Session courses: #{session[:courses]}"
  end

  def show
    puts "called for params #{params}"
  end
end
