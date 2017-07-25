class V1::FollowersController < V1::BaseController

  # GET /v1/members/1/followers
  def index
    user = User.find params[:member_id]
    @followers = user.followers.page current_page
    render_success data: {
        followers: ActiveModel::Serializer::CollectionSerializer.new(@followers, serializer: UserSerializer),
        total_pages: @followers.total_pages,
        current_page: @followers.current_page,
        next_page: @followers.next_page,
        prev_page: @followers.prev_page,
        first_page: @followers.first_page?,
        last_page: @followers.last_page?
    }

  end
end  
