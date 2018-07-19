class UserStory < ApplicationRecord
  belongs_to :user
  has_many :media, class_name: :user_story_media
end
