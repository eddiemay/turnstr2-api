class AddIndexToDevice < ActiveRecord::Migration[5.0]
  def change
    add_index :user_devices, [:device_udid, :user_id], unique: true
  end
end
