class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :month, :year, :title, :cover_image_url
end
