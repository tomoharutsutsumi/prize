class CreateAwardCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :award_categories do |t|
      t.integer :level, null: false
      t.timestamps
    end
  end
end
