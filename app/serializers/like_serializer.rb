class LikeSerializer < ActiveModel::Serializer
  attributes :id, :likable_type, :likable_id, :created_at

  belongs_to :user, serilalizer: 'UserSerializer'
end
