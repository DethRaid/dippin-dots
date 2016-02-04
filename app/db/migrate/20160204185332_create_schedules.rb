class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :credit_limit

      t.timestamps null: false
    end
  end
end
