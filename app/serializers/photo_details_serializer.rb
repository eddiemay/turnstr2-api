class PhotoDetailsSerializer < PhotosSerializer
  attributes :has_liked

  def has_liked
    object.has_liked(@instance_options[:current_user])

  end  
end
