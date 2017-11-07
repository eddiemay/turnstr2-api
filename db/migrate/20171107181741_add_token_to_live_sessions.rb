class AddTokenToLiveSessions < ActiveRecord::Migration[5.0]
  def change
    add_column :live_sessions, :token, :text
  end
end
