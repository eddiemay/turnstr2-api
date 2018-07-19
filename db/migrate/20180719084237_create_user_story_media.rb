class CreateUserStoryMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :user_story_media do |t|
      t.references :user_story, foreign_key: true
      t.attachment :media
      t.timestamps
    end
  end
end
