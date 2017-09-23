class CreateLiveStream < ActiveRecord::Migration[5.0]
  def change
    create_table :live_sessions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :session_id, index: true
      t.boolean :completed, default: false

      t.timestamps

    end
  end
end
