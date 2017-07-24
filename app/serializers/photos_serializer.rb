class PhotosSerializer < ActiveModel::Serializer
  attributes :id, :image_thumb, :image_medium, :image_original, :likes_count, :comments_count, :captured_date, :created_at

  def image_thumb
  	object.image.url(:thumb)
  end	

  def image_medium
  	object.image.url(:medium)
  end	

  def image_original
  	object.image.url
  end	
end
