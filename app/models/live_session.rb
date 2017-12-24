class LiveSession < ApplicationRecord
  extend Enumerize

	belongs_to :user

	has_many :video_stories, class_name: 'GoLiveVideo', foreign_key: :opentok_session_id, primary_key: :session_id

  enumerize :session_type, in: [:video_call, :go_live], default: :video_call

end
