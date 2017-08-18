class UserDetailsSerializer < UserSerializer
	attributes :following, :following_me, :family_member, :favourite
  def following
  	@instance_options[:current_user].following?(object)
  end	

  def following_me
  	object.following?(@instance_options[:current_user])
  end	
  def family_member
  	@instance_options[:current_user].family_member?(object)
  end	

  def favourite
    @instance_options[:current_user].favourite?(object)
  end  
end
