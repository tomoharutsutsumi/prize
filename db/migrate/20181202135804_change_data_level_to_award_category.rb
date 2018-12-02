class ChangeDataLevelToAwardCategory < ActiveRecord::Migration[5.1]
  def change
    change_column :award_categories, :level, :string
  end
end
