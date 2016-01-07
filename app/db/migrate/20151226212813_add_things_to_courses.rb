class AddThingsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :course_id, :string
    add_column :courses, :num_credits, :integer
  end
end
