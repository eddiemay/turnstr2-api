class V1::User::ProfilesController < V1::User::BaseController



	def show

		render json: params

	end		

end
