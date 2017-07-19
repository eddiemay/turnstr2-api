class UpdateStory < ActiveRecord::Migration[5.0]
  def change
  	change_table :stories do |t|
  	  t.attachment :face5_video_thumb
    	t.attachment :face6_video_thumb
    	t.attachment :face5_media
    	t.attachment :face6_media
    end	
  end
end
