class UserStoryViewSerializer < ActiveModel::Serializer
	attributes :id, :user, :created_at

  belongs_to :user, serializer: UserListSerializer
end