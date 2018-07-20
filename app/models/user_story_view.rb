class UserStoryView < ApplicationRecord
  belongs_to :user_story
  belongs_to :user
end
