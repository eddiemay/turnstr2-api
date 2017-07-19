class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
    	t.references :user, foreign_key: true
			t.string :likable_type
			t.integer :likable_id
			t.timestamps
    end

    add_index :likes, [:likable_type, :likable_id]
    add_index :likes, [:user_id, :likable_type, :likable_id], unique: true
  end
end
