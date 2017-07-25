class V1::FollowingController < V1::BaseController

  # GET /v1/members/1/following
  def index
    @user = User.find params[:member_id]
    @following = @user.following.page current_page
    render_success data: {
        following: ActiveModel::Serializer::CollectionSerializer.new(@following, serializer: UserSerializer),
        total_pages: @following.total_pages,
        current_page: @following.current_page,
        next_page: @following.next_page,
        prev_page: @following.prev_page,
        first_page: @following.first_page?,
        last_page: @following.last_page?
    }

  end
end  
