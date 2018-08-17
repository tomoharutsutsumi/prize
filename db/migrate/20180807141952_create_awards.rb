class CreateAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :awards do |t|
      t.text :contents
      t.date :day

      t.timestamps
    end
  end
end
