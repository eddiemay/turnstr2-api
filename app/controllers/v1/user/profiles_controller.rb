class V1::User::ProfilesController < V1::User::BaseController



	def show
		render_success data: { user: UserSerializer.new(@current_user) }
	end


	def update
		if current_user.update user_params
      render_success data: {user: UserSerializer.new(current_user)}, message: I18n.t('resource.updated', resource: User.model_name.human)
    else
      render_unprocessable_entity message: current_user.errors.full_messages.join(', ')
    end

	end	

  private


  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :username, :info, :phone, :first_name, :last_name, :gender, :avatar_face1, :avatar_face2, :avatar_face3, :avatar_face4, :avatar_face5, :avatar_face6,
    															:website, :bio, :address, :city, :state, :contact_me, :online)
    
  end	

end
