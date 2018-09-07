class AddGivenAndGiverIdToAwards < ActiveRecord::Migration[5.1]
  def change
    add_column :awards, :giver_id, :integer
    add_column :awards, :given_id, :integer
    remove_column :awards, :user_id, :integer
  end
end
