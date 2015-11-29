class SearchController < ApplicationController
  def create
    # V1: grab all courses with the given ID
    # V2: grab all courses with the given ID -or- grab all courses with a
    #   fuzzy-search match with the search term, sorted by relevance
    @courses = get_courses_for_search_term(params)
  end

  private
  def get_courses_for_search_term(search_term)
    [Course.new({:title => 'Course title', :description => 'Course description'})]
  end
end
