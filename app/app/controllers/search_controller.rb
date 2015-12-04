class SearchController < ApplicationController
  def create
    # V1: grab all courses with the given ID
    # V2: grab all courses with the given ID -or- grab all courses with a
    #   fuzzy-search match with the search term, sorted by relevance
    @courses = get_courses_for_search_term(params[:search])
  end

  private
  def get_courses_for_search_term(search_term)
    # Check if the input is a course id
    if search_term =~ /[A-Z0-9]{4}-[0-9]{3}/
      [Course.where(title: search_term).take]
    else
      puts "Seaching for #{search_term}"
      Course.find_by_fuzzy_description(search_term, :limit => 10)
    end
  end
end
