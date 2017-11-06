class UserDevice < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :device_udid, :scope => [:user_id]
end
