class SearchController < ApplicationController
  def create
    # V1: grab all courses with the given ID
    # V2: grab all courses with the given ID -or- grab all courses with a
    #   fuzzy-search match with the search term, sorted by relevance
    @courses = get_courses_for_search_term(params[:search])
  end

  private
  def get_courses_for_search_term(search_term)
    [Course.where(title: search_term).take]
  end
end
