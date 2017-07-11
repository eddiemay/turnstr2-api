class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
    	t.references :user, foreign_key: true
    	t.integer :month
    	t.integer :year
    	t.string :title
    	t.string :cover_image_url

      t.timestamps
    end

    add_index :albums, [:user_id, :month, :year], unique: true
  end
end
