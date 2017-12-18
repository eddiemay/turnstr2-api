class AddSessionToDevice < ActiveRecord::Migration[5.0]
  def change
    add_column :user_devices, :session_id, :string
  end
end
