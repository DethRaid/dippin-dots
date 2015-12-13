class TrigramsController < ApplicationController
  # Updates the trigrams for every fuzzily-searchable model
  def index
    # Do anything we need to do when the app starts up
    Course.bulk_update_fuzzy_description
  end
end
