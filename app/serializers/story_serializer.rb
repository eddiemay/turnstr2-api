class StorySerializer < ActiveModel::Serializer
	attributes :id, :user_id, :caption, :likes_count, :face1_thumb, :face2_thumb, :face3_thumb, :face4_thumb, :story_face1, :story_face2, :story_face3, :story_face4, :active
end