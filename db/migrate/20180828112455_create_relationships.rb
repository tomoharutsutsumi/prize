class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :giver_id
      t.integer :given_id

      t.timestamps
    end
    add_index :relationships, :giver_id
    add_index :relationships, :given_id
    add_index :relationships, [:giver_id, :given_id], unique: true
  end
end
