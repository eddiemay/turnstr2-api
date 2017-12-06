class UserListSerializer < ActiveModel::Serializer
    attributes :id, :username, :first_name, :last_name, :avatar_face1, :avatar_face2, :avatar_face3,
               :avatar_face4, :avatar_face5, :avatar_face6, :online, :is_verified


  %w(avatar_face1 avatar_face2 avatar_face3 avatar_face4 avatar_face5 avatar_face6).each do |attr|
    define_method attr do
      if object.send(attr).present?
        object.send(attr).try(:url, :thumb)
      end
    end
  end

end
