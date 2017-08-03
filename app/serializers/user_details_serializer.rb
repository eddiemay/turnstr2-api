class UserDetailsSerializer < UserSerializer
	attributes :following
  def following
  	@instance_options[:current_user].following?(object)
  end	
end
