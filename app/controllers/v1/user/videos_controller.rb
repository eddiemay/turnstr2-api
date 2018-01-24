class V1::User::VideosController < V1::User::BaseController

  # GET /user/video
  def index
    # temporary
    @videos = current_user.videos.page current_page
    render_success data: {
        stories: ActiveModel::Serializer::CollectionSerializer.new(@videos, serializer: VideosSerializer),
        total_pages: @videos.total_pages,
        current_page: @videos.current_page,
        next_page: @videos.next_page,
        prev_page: @videos.prev_page,
        first_page: @videos.first_page?,
        last_page: @videos.last_page?
    }
  end

end
