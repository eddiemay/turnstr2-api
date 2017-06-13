class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.attachment :avatar_face1
      t.attachment :avatar_face2
      t.attachment :avatar_face3
      t.attachment :avatar_face4
      t.attachment :avatar_face5
      t.attachment :avatar_face6

      t.string :fb_token
      t.string :website
      t.string :bio
      t.string :gender
      t.string :remember_token
      t.string :address
      t.string :city
      t.string :state
      t.integer :post_count, default: 0
      t.integer :following_count, default: 0
      t.integer :follower_count, default: 0
      t.integer :family_count, default: 0
      t.text :info
      t.string :website
      t.string :contact_me
      t.boolean :online, default: false
      t.boolean :is_verified, default: false
      t.boolean :is_active, default: true
      t.string :role

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
