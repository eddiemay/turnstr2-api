class UserStorySerializer < ActiveModel::Serializer
	attributes :id, :thumb_url, :view_count

	belongs_to :user


end