class GoLiveVideo < ApplicationRecord

  # https://s3-us-west-2.amazonaws.com/turnstr2-production/45910392/012b1572-95cf-42d0-9802-e6dae5d06aeb/archive.mp4
  include CanBeLiked
  include CanBeCommented
  default_scope { order(created_at: :desc) }

  # belongs_to :live_session

  has_many :comments, as: :commentable
  has_many :likes, as: :likable

  scope :uploaded, -> {where(status: 'uploaded').order("created_at desc")}


  def url
    'https://' + Rails.application.secrets.s3_host_name + '/' + Rails.application.secrets.s3_bucket  + '/' + Rails.application.config.open_tok_api_key + '/' + (opentok_id || '') +  '/archive.mp4'
  end

end
