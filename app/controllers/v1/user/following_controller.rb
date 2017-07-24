class V1::User::FollowingController < V1::User::BaseController


  # GET /v1/user/followers
  def index
    @following = current_user.following.page current_page
    render_success data: {
        following: ActiveModel::Serializer::CollectionSerializer.new(@following, serializer: UserListSerializer),
        total_pages: @following.total_pages,
        current_page: @following.current_page,
        next_page: @following.next_page,
        prev_page: @following.prev_page,
        first_page: @following.first_page?,
        last_page: @following.last_page?
    }

  end
end  