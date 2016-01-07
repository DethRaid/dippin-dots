class AddCoursesFromCsvController < ApplicationController
  CSV_FILE_LOCATION = '../data/csv'
  def show
    filename = params[:id]

    # Read in the csv file from the csv_file_loacation
    filename = CSV_FILE_LOCATION + filename

    # I'm going to assume that the csv is parsed into a list of hashes, where each hash has the CSV column names as the
    # hash keys
    csv_loaded = load_csv(filename)

    [
        {:title => 'SWEN-261', :description => 'The worst'},
        {:title => 'CSCI-240', :description => 'CS Theory'},
        {:title => 'SWEN-262', :description => 'Refactoring'},
        {:title => 'MLAS-301', :description => 'Intermediate ASL 1'},
        {:title => 'CSMP-250', :description => 'Assembly'},
        {:title => 'CMPE-240', :description => 'Assembler'}
    ]

    csv_loaded.each do |value|
      Course.new()
    end
  end
end
