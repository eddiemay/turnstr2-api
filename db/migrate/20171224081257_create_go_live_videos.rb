class CreateGoLiveVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :go_live_videos do |t|

      t.string :opentok_id
      t.string :event
      t.string :opentok_created_at
      t.integer :duration
      t.integer :partner_id
      t.string :reason
      t.string :opentok_session_id, index:true
      t.integer :size
      t.string :status
      t.string :url

      t.timestamps
    end
  end
end
