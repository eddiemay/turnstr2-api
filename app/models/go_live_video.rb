class GoLiveVideo < ApplicationRecord

  include CanBeLiked
  include CanBeCommented
  default_scope { order(created_at: :desc) }

  # belongs_to :live_session

  has_many :comments, as: :commentable
  has_many :likes, as: :likable

end
