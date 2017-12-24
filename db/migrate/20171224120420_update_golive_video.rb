class UpdateGoliveVideo < ActiveRecord::Migration[5.0]
  def change
    add_column :go_live_videos, :thumb_url, :string
    add_column :go_live_videos, :likes_count, :integer
    add_column :go_live_videos, :comments_count, :integer

  end
end
