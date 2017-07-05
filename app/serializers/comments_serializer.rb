class CommentsSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at

  belongs_to :user, serilalizer: 'UserSerializer'
end
