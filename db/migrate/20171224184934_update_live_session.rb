class UpdateLiveSession < ActiveRecord::Migration[5.0]
  def change
    add_column :live_sessions, :session_type, :string
  end
end
