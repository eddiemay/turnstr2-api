class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
    	t.references :user, foreign_key: true
    	t.string :caption
    	t.integer :total_likes
    	t.attachment :story_face1_thumb_url
    	t.attachment :story_face2_thumb_url
    	t.attachment :story_face3_thumb_url
    	t.attachment :story_face4_thumb_url
    	t.attachment :story_face1_url
    	t.attachment :story_face2_url
    	t.attachment :story_face3_url
    	t.attachment :story_face4_url
    	t.boolean :active, default: false
      	t.timestamps
    end
  end
end
