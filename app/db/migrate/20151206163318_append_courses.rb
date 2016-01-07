class AppendCourses < ActiveRecord::Migration
  def change
    add_column :courses, :id, :string
    add_column :courses, :num_credits, :integer
  end
end
