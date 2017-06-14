class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
    	t.references :user, index: true
    	t.attachment :image
    	t.date :captured_date
    	t.string :visibility

      t.timestamps
    end

    add_foreign_key :photos, :users
    add_index :photos, [:user_id, :visibility]
  end
end
