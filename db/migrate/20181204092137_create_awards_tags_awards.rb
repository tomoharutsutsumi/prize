class CreateAwardsTagsAwards < ActiveRecord::Migration[5.1]
  def change
    create_table :award_tags_awards do |t|
      t.integer :award_id, foreign_key: true, null: false
      t.integer :award_tag_id, foreign_key: true, null: false
    end
  end
end
