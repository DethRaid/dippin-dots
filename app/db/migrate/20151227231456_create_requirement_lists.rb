class CreateRequirementLists < ActiveRecord::Migration
  def change
    create_table :requirement_lists do |t|
      t.string :name
      t.string :abbreviation
      t.string :type  # can be :major, :minor, :lai (liberal arts immersion), :app_domain (application domain or similar)
      t.timestamps null: false
    end
  end
end
