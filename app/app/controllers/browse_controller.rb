class BrowseController < ApplicationController
  def show
    id = params[:id]
    if id == 'courses'
      @items = organize_courses_alphabetically
    end
  end

  private
  def organize_courses_alphabetically
    ret_val = Hash.new([])

    Course.find_each do |course|
      key = course.title[/^[A-Z0-9]{4}/]
      ret_val[key] += [course]
    end

    ret_val
  end
end
