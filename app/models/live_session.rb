class LiveSession < ApplicationRecord
	belongs_to :user

	has_many :video_stories, class_name: 'GoLiveVideo', foreign_key: :opentok_session_id, primary_key: :session_id

end
