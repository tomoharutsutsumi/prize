class RenameTypeInAwardTag < ActiveRecord::Migration[5.1]
  def change
    rename_column :award_tags, :type, :tag
  end
end
