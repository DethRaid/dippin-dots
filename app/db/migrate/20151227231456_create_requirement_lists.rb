class CreateRequirementLists < ActiveRecord::Migration
  def change
    create_table :requirement_lists do |t|

      t.timestamps null: false
    end
  end
end
