class CreateUserStoryViews < ActiveRecord::Migration[5.0]
  def change
    create_table :user_story_views do |t|
      t.references :user_story, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :user_story_views, [:user_story_id, :user_id], unique: true
  end
end
