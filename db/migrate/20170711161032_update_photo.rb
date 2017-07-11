class UpdatePhoto < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :photos, :user, index: true, foreign_key: true
  	add_reference :photos, :album, index: true, foreign_key: true
  end
end
