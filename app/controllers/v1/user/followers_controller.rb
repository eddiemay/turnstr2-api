class V1::User::FollowersController < V1::User::BaseController

  # GET /photos
  def index
    followers = current_user.followers.page current_page
    render_success data: {
        followers: ActiveModel::Serializer::CollectionSerializer.new(followers, serializer: UserListSerializer),
        total_pages: followers.total_pages,
        current_page: followers.current_page,
        next_page: followers.next_page,
        prev_page: followers.prev_page,
        first_page: followers.first_page?,
        last_page: followers.last_page?

    }
  end
end  