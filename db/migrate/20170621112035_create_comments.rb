class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
    	t.references :user, foreign_key: true
			t.boolean :is_approved, default: false
			t.string :commentable_type
			t.integer :commentable_id
			t.text :body
			t.timestamps
    end
  end
end
