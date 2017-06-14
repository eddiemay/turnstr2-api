class StorySerializer < ActiveModel::Serializer
	attributes :id, :user_id, :caption, :total_likes, :story_face1_thumb_url, :story_face2_thumb_url, :story_face3_thumb_url, :story_face4_thumb_url, :story_face1_url, :story_face2_url, :story_face3_url, :story_face4_url, :active
end