class CreateUserDevices < ActiveRecord::Migration[5.0]
  def change
    create_table :user_devices do |t|
      t.references :user, index: true, foreign_key: true
      t.string :device_udid, index:true
      t.string :device_push_token
      t.string :device_name
      t.string :device_ios

      t.timestamps
    end
  end
end
