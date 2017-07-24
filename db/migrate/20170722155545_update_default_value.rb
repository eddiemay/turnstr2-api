class UpdateDefaultValue < ActiveRecord::Migration[5.0]
  def change
  	change_column_default(:stories, :likes_count, 0)
  	change_column_default(:stories, :comments_count, 0)
  	change_column_default(:photos, :likes_count, 0)

  end
end
