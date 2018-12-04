class CreateAwardTags < ActiveRecord::Migration[5.1]
  def change
    create_table :award_tags do |t|
      t.string :type

      t.timestamps
    end
  end
end
