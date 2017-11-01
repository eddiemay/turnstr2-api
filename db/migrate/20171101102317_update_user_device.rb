class UpdateUserDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :user_devices, :voip_token, :string
  end
end
