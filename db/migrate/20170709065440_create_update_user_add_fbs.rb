class CreateUpdateUserAddFbs < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :fb_user_id, :integer, limit: 8
  	add_index :users, :fb_user_id, unique: true

  end
end
