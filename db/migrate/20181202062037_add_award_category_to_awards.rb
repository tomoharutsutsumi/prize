class AddAwardCategoryToAwards < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :award_category_id, :integer, null: false
  end
end
