class CreateAdmin < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :first_name
      t.string :last_name
      t.string :phone
    end
    add_index :admins, :email, unique: true

  end
end
