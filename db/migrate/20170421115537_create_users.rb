class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :first_name

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
