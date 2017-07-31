class PhotoDetailsSerializer < PhotosSerializer
  attributes :has_liked

  belongs_to :user
  def has_liked
    object.has_liked(@instance_options[:current_user])

  end  
end
