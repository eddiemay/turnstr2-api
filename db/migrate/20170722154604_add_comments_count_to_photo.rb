class AddCommentsCountToPhoto < ActiveRecord::Migration[5.0]
  def change
  	add_column :photos, :comments_count, :integer, default: 0
  end
end
