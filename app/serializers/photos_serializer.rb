class PhotosSerializer < ActiveModel::Serializer
  attributes :id, :image, :captured_date, :created_at
end
