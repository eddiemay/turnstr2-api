class CreateUserStories < ActiveRecord::Migration[5.0]
  def change
    create_table :user_stories do |t|
      t.references :user, foreign_key: true
      t.integer :view_count, default: 0
      t.string :thumb_url

      t.timestamps
    end
  end
end
