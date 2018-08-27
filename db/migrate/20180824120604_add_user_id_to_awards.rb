class AddUserIdToAwards < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :user_id, :integer
  end
end
