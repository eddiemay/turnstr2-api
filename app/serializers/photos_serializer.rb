class PhotosSerializer < ActiveModel::Serializer
  attributes :id, :image, :captured_date, :created_at, :month_group
end
