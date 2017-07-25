class V1::UnfollowController < V1::BaseController

  # POST /v1/members/1/unfollow
  def create
    @user = User.find(params[:member_id])
    current_user.unfollow(@user)
      render_success data: {user: UserListSerializer.new(@user) }, message: I18n.t('resource.deleted', resource: Follow.model_name.human)
  end

end