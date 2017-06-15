class CreateStories < ActiveRecord::Migration[5.0]
  def change
    create_table :stories do |t|
    	t.references :user, foreign_key: true
    	t.string :caption
    	t.integer :likes_count
        t.integer :comments_count
    	t.attachment :face1_video_thumb
    	t.attachment :face2_video_thumb
    	t.attachment :face3_video_thumb
    	t.attachment :face4_video_thumb
    	t.attachment :face1_media
    	t.attachment :face2_media
    	t.attachment :face3_media
    	t.attachment :face4_media
    	t.boolean :active, default: true
      	t.timestamps
    end
  end
end
