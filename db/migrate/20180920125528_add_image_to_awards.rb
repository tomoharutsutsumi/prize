class AddImageToAwards < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :image, :string
  end
end
