class V1::FollowController < V1::BaseController

  # POST /v1/members/1/follow
  def create
    @user = User.find(params[:member_id])
    current_user.follow(@user)
    render_success data: {user: UserListSerializer.new(@user) }, message: I18n.t('resource.created', resource: Follow.model_name.human)
  end

end