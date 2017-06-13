class V1::User::ProfilesController < V1::User::BaseController



	def show
		render_success data: { user: UserSerializer.new(@current_user) }
	end		

end
