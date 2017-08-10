class CreateFavourites < ActiveRecord::Migration[5.0]
  def change
    create_table :favourites, id: false do |t|
      t.integer :user_id
      t.integer :favourite_user_id    		
      t.timestamps
    end

    add_index(:favourites, [:user_id, :favourite_user_id], :unique => true)
    add_index(:favourites, [:favourite_user_id, :user_id], :unique => true)

  end
end
