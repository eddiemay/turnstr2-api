class StoryDetailsSerializer < StorySerializer
	attributes :has_liked

  def has_liked
    object.has_liked(@instance_options[:current_user])

  end  

end	